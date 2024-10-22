# Crimes in City, NY
## Project Description
This project contains a database of crimes in Buffalo, NY, spanning from 2020 to 2021. The goal is to enable detailed analysis of crime patterns in the city, allowing law enforcement agencies and other stakeholders to use a web-based system for accessing and analyzing crime data.

### Table of Contents
1. Installation
2. Usage
3. Data Pre-process and Augmentation
4. Database Structure
5. Queries
6. Bonus Task
7. Contribution
8. References

### Installation
The project requires the following tools and libraries for data cleaning, database management, and web interface:

Python - For data pre-processing and augmentation.
MySQL Workbench - For managing the database schema and running SQL queries.
Streamlit - For building a simple web-based interface to interact with the database in real-time.
Steps:
Install MySQL Workbench and Streamlit:
pip install streamlit
Clone the repository and navigate to the project directory.
Make sure to have Python installed and the necessary packages as mentioned in the requirements.txt file.

### Usage
The project allows users to run SQL queries and retrieve real-time results through a web-based interface.

### Web Interface
The web interface is built using Streamlit and allows users to input SQL queries and view the results dynamically.
Users can enter SQL queries through a text box, execute them, and see results immediately on the same page.

### Data Pre-process and Augmentation

Run the following Python scripts to sanitize and modify the dataset:
data_sanitization.py: Cleans up any formatting issues.
modify_columns.py: Pre-processes the data to fit the normalized database schema.
Creating Tables and Importing Data
Run the create.sql script to create a new schema called crime_final and the associated tables.

#### Database Structure
The project uses a normalized database schema based on the Buffalo Crime Dataset, consisting of the following key tables:

Crime Data: Raw data of all incidents.
Council District: Holds council district data.
Neighborhood: Contains neighborhood information linked to each crime.
Police District: Data for police districts.
Crime Incidents: Captures incident details, types, and investigation status.
Location: Data related to incident locations.
Incident Type: Defines the type and parent type of incidents.
Each of these tables conforms to Boyce-Codd Normal Form (BCNF), ensuring proper normalization and avoiding redundancy.

### Queries
#### Example SELECT Queries:
1. Get the number of crimes for every police district:

SELECT police_district_id, COUNT(*) AS crime_count 
FROM crime_incidents 
GROUP BY police_district_id;

2. Get the number of resolved cases for every police district:

SELECT police_district_id, COUNT(*) AS resolved_cases
FROM crime_incidents 
WHERE investigation_status = 'Resolved'
GROUP BY police_district_id;

### Example INSERT Query:
Inserting a new crime into the crime_data table automatically triggers an INSERT into the corresponding normalized tables:

INSERT INTO crime_data (case_number, incident_id, ...)
VALUES ('12345', 9876, ...);
Bonus Task
The project includes a bonus task that adds a Streamlit-based web interface. To run it:

This starts a web-based SQL query tool where users can input and run queries on the database. The results are displayed in the browser in real-time.

### Contribution
The project was a collaborative effort by:
1. Deepthi D’Souza
2. Sankalp Mehani
3. Pritish Kamble

### References
1. DBMS Normalization Tutorial
2. PostgreSQL Python Connection
3. SQL Server Clustered Indexes
4. SQL After Insert Triggers
