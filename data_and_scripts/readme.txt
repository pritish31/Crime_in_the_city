
DMQL project - Buffalo Crime - Group 15


Data Source: https://data.buffalony.gov/Public-Safety/Crime-Incidents/d6g9-xbgu

Data Pre-process and Augmentation: 
Download the csv file from the above data source. 
Run data_sanitization.py and modify_columns.py to pre-process and augment the dataset.

Creating tables and Importing data:

1. Run create.sql to create new schema called crime_final and 8 tables within the schema.
2. Import dataset buffalo_crime_v2.csv into crime_final.crime_data table.
3. Run load.sql to bulk load data from crime_final.crime_data table to 7 normalized tables.
4. Run trigger.sql to create insert, update and delete triggers.

Bonus: 

1. Add Postgres DB username and password in the code bonus_task_project_ui.py
2. Run the command below to start Streamlit Web UI in the browser:
   streamlit run <file_path\bonus_task_project_ui.py>
   




