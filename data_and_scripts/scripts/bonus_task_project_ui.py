# import required libraries
import streamlit as st
import pandas as pd 
import psycopg2

conn = psycopg2.connect(
    host="localhost",
    database="buffalo_crime",
    user="postgres",
    password=1224)

# Create a Streamlit page
st.title("Buffalo Crime Database: SQL Query Tool")

# Create a text box for the SQL query input
sql_query = st.text_area("Enter SQL Query:")

# Create a button to execute the SQL query
if st.button("Execute Query"):
    # Create a cursor object and execute the SQL query
    cur = conn.cursor()
    try:
        cur.execute(sql_query)
        results = cur.fetchall()
        df = pd.DataFrame(results, columns=[desc[0] for desc in cur.description])
    except:
        st.write("There's an error in your query!")
    
    # Display the results in a table
    if results:
        st.write("Query Results:")
        st.write(df)
    else:
        st.write("Invalid SQL statement")

# Close the database connection
conn.close()
