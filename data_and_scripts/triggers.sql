
-- INSERT TRIGGER

CREATE OR REPLACE FUNCTION insert_into_normalized_tables()
RETURNS TRIGGER AS $$
BEGIN
  -- Insert data into incident_datetime table
  INSERT INTO crime_final.incident_datetime("Incident ID", "Incident Datetime", "Created At", "Updated At")
  VALUES (NEW."Incident ID", NEW."Incident Datetime", NEW."Created At", NEW."Updated At");
  
  -- Insert data into location table
  INSERT INTO crime_final.location("Incident ID", "Address", "Neighborhood ID")
  SELECT NEW."Incident ID", NEW."Address", neighborhood."Neighborhood ID"
  FROM crime_final.neighborhood
  WHERE neighborhood."Neighborhood" = NEW."Neighborhood"
  ON CONFLICT ("Incident ID") DO NOTHING;

  -- Insert data into crime_incidents table
  INSERT INTO crime_final.crime_incidents("Case Number", "Incident ID", "Investigation Status", "Police District ID", "Incident Type ID")
  SELECT NEW."Case Number", NEW."Incident ID", NEW."Investigation Status", pd."Police District ID", it."Incident Type ID"
  FROM crime_final.police_district AS pd, crime_final.incident_type AS it
  WHERE pd."Police District" = NEW."Police District"
  AND it."Incident Type" = NEW."Incident Type"
  ON CONFLICT ("Case Number") DO NOTHING;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create Insert trigger
CREATE TRIGGER insert_normalized_tables_trigger
AFTER INSERT ON crime_final.crime_data
FOR EACH ROW
EXECUTE FUNCTION insert_into_normalized_tables();

----------------------------------------------------------------------------------------------------------------
-- DELETE TRIGGER
CREATE OR REPLACE FUNCTION delete_from_normalized_tables() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM crime_final.incident_datetime WHERE "Incident ID" = OLD."Incident ID";
    DELETE FROM crime_final.location WHERE "Incident ID" = OLD."Incident ID";
    DELETE FROM crime_final.crime_incidents WHERE "Incident ID" = OLD."Incident ID";
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Create Delete trigger
CREATE TRIGGER delete_normalized_tables_trigger
AFTER DELETE ON crime_final.crime_data
FOR EACH ROW
EXECUTE FUNCTION delete_from_normalized_tables();

----------------------------------------------------------------------------------------------------------------
-- UPDATE TRIGGER

CREATE OR REPLACE FUNCTION update_normalized_tables()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE crime_final.incident_datetime SET
        "Incident Datetime" = NEW."Incident Datetime",
        "Updated At" = now()
    WHERE "Incident ID" = NEW."Incident ID";

    UPDATE crime_final.location SET
        "Address" = NEW."Address"
    WHERE "Incident ID" = NEW."Incident ID";

    UPDATE crime_final.crime_incidents SET
        "Investigation Status" = NEW."Investigation Status",
        "Police District ID" = (SELECT "Police District ID" FROM crime_final.police_district WHERE "Police District" = NEW."Police District"),
        "Incident Type ID" = (SELECT "Incident Type ID" FROM crime_final.incident_type WHERE "Incident Type" = NEW."Incident Type")
    WHERE "Case Number" = NEW."Case Number";

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create Update trigger
CREATE TRIGGER update_normalized_tables_trigger
AFTER UPDATE ON crime_final.crime_data
FOR EACH ROW
EXECUTE FUNCTION update_normalized_tables();


