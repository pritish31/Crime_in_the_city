
-- CREATE STATEMENTS 

create schema if not exists public;
revoke usage on schema public from public;
CREATE SCHEMA if not exists crime_final;

--DROP TABLE IF EXISTS crime_final.crime_data;

CREATE TABLE IF NOT EXISTS crime_final.crime_data
(
    "Case Number" character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "Incident ID" integer NOT NULL,
    "Incident Datetime" timestamp without time zone,
    "Incident Type" character varying(40) COLLATE pg_catalog."default",
    "Parent Incident Type" character varying(40) COLLATE pg_catalog."default",
    "Address" character varying(40) COLLATE pg_catalog."default",
    "Neighborhood" character varying(40) COLLATE pg_catalog."default",
    "Police District" character varying(20) COLLATE pg_catalog."default",
    "Council District" character varying(20) COLLATE pg_catalog."default",
    "Created At" timestamp without time zone NOT NULL,
    "Updated At" timestamp without time zone,
    "Investigation Status" character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT crime_data_pkey PRIMARY KEY ("Case Number")
);


--DROP TABLE IF EXISTS crime_final.incident_datetime;

CREATE TABLE IF NOT EXISTS crime_final.incident_datetime
(
    "Incident ID" integer NOT NULL,
    "Incident Datetime" timestamp without time zone,
    "Created At" timestamp without time zone,
    "Updated At" timestamp without time zone,
    CONSTRAINT incident_datetime_pkey PRIMARY KEY ("Incident ID")
);



--DROP TABLE IF EXISTS crime_final.council_district;

CREATE TABLE IF NOT EXISTS crime_final.council_district
(
    "Council District ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    "Council District" character(20) COLLATE pg_catalog."default",
    CONSTRAINT council_district_pkey PRIMARY KEY ("Council District ID")
);


--DROP TABLE IF EXISTS crime_final.neighborhood;

CREATE TABLE IF NOT EXISTS crime_final.neighborhood
(
"Neighborhood ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 1
MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
"Neighborhood" character(40) COLLATE pg_catalog."default",
"Council District ID" integer NOT NULL,
CONSTRAINT neighborhood_pkey PRIMARY KEY ("Neighborhood ID"),
CONSTRAINT CouncilDistrict_fkey FOREIGN KEY ("Council District ID")
REFERENCES crime_final.council_district ("Council District ID") MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
);


--DROP TABLE IF EXISTS crime_final.location;

CREATE TABLE IF NOT EXISTS crime_final.location
(
"Incident ID" integer NOT NULL,
"Address" character varying(40) COLLATE pg_catalog."default",
"Neighborhood ID" integer,
CONSTRAINT location_pkey PRIMARY KEY ("Incident ID"),
CONSTRAINT "location_neighborhood_fkey" FOREIGN KEY ("Neighborhood ID")
REFERENCES crime_final.neighborhood ("Neighborhood ID") MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
);


--DROP TABLE IF EXISTS crime_final.incident_type;

CREATE TABLE IF NOT EXISTS crime_final.incident_type
(
"Incident Type ID" INT GENERATED ALWAYS AS IDENTITY,
"Incident Type" character varying(40) COLLATE pg_catalog."default",
"Parent Incident Type" character varying(40) COLLATE pg_catalog."default",
CONSTRAINT incident_type_pkey PRIMARY KEY ("Incident Type ID")
);


--DROP TABLE IF EXISTS crime_final.police_district;

CREATE TABLE IF NOT EXISTS crime_final.police_district
(
"Police District ID" smallint NOT NULL GENERATED ALWAYS AS IDENTITY (INCREMENT 1 START 1
MINVALUE 1 MAXVALUE 32767 CACHE 1 ),
"Police District" character(20) COLLATE pg_catalog."default",
CONSTRAINT police_district_pkey PRIMARY KEY ("Police District ID")
);

--DROP TABLE IF EXISTS crime_final.crime_incidents;

CREATE TABLE IF NOT EXISTS crime_final.crime_incidents
(
"Case Number" character varying(20) COLLATE pg_catalog."default" NOT NULL,
"Incident ID" integer NOT NULL,
"Investigation Status" character varying(50) COLLATE pg_catalog."default",
"Police District ID" integer,
"Incident Type ID" integer,
CONSTRAINT crime_incidents_pkey PRIMARY KEY ("Case Number"),
CONSTRAINT "crime_incidents_Incident ID_key" UNIQUE ("Incident ID"),
CONSTRAINT "crime_incidents_Incident Type_fkey" FOREIGN KEY ("Incident Type ID")
REFERENCES crime_final.incident_type ("Incident Type ID") MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION,
CONSTRAINT "crime_incidents_Police District_fkey" FOREIGN KEY ("Police District ID")
REFERENCES crime_final.police_district ("Police District ID") MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
);


