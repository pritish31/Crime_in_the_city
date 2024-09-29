--TRUNCATE STATEMENTS

truncate table crime_final.location,crime_final.neighborhood,crime_final.council_district;
truncate table crime_final.incident_type,crime_final.crime_incidents,crime_final.police_district;
truncate table crime_final.incident_datetime;
-- truncate table crime_final.crime_data;


-- INSERT STATEMENTS

------------------------------------ Insert data into incident datetime table----------------------------------------

insert into crime_final.incident_datetime ("Incident ID","Incident Datetime","Created At","Updated At")
select distinct "Incident ID","Incident Datetime","Created At","Updated At" from crime_final.crime_data;

------------------------------------ Insert data into council district table------------------------------------------

insert into crime_final.council_district("Council District")
select distinct "Council District" from crime_final.crime_data;

------------------------------------ Insert data into neighborhood table----------------------------------------------

INSERT INTO crime_final.neighborhood("Neighborhood", "Council District ID")
SELECT DISTINCT crd."Neighborhood", cd."Council District ID"
FROM crime_final.crime_data AS crd
JOIN crime_final.council_district AS cd ON crd."Council District" = cd."Council District";

----------------------------------- Insert data into location table ---------------------------------------------------

insert into crime_final.location("Incident ID", "Address", "Neighborhood ID")
select distinct "Incident ID", "Address", neighborhood."Neighborhood ID" from crime_final.crime_data
join crime_final.neighborhood on crime_data."Neighborhood" = neighborhood."Neighborhood";

---------------------------------- Insert data into incident_type table -----------------------------------------------
insert into crime_final.incident_type("Incident Type", "Parent Incident Type")
select distinct "Incident Type", "Parent Incident Type" from crime_final.crime_data;

---------------------------------- Insert data into police district table ----------------------------------------------
insert into crime_final. police_district ("Police District")
select distinct "Police District" from crime_final.crime_data;

---------------------------------- Insert data into crime_incidents table------------------------------------------------
insert into crime_final.crime_incidents("Case Number", "Incident ID", "Investigation Status", "Police District ID", "Incident Type ID")
select distinct "Case Number", "Incident ID", "Investigation Status",
p."Police District ID", incident_type."Incident Type ID"
from crime_final.crime_data
join crime_final.police_district as p on crime_final.crime_data."Police District" = p."Police District"
join crime_final.incident_type on crime_final.crime_data."Incident Type" = incident_type."Incident Type";




