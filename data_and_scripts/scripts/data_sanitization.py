import random
import pandas as pd
pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

df = pd.read_csv("Buffalo_crime.csv.xls")

# add new column 'Investigation Status'
df['Investigation Status'] = random.choices(["Resolved", "Active", "Suspended"], k=len(df))

# drop the surplus columns and remove rows with 'NaN' values
df.drop(columns=['Incident Description', 'Latitude', 'Longitude', 'updated_at'], inplace=True)
df.dropna(how='any', inplace=True)

# insert a new column 'Updated At' indexed after the 'Created At' column
df.insert(loc=12, column='Updated At', value=df['Created At'])

# remove rows with dates having wrong format
df = df[df["Created At"].str.contains("PM") == False]
df = df[df["Created At"].str.contains("AM") == False]

# fill the 'Updated At' values for all rows
for index, row in df.iterrows():
    
    if row['Investigation Status'] == "Active": continue

    date = row['Created At']
    day = int(date.split('-')[1])
    month = int(date.split('-')[0])
    year = int(date.split('-')[2].split()[0])

    # update year
    if month == 12: updated_year = year + random.randint(1, 2)
    else: updated_year = year + random.randint(0, 2)

    # update month
    if updated_year == year: updated_month = random.randint(month + 1, 12)
    else: updated_month = random.randint(1, 12)
    
    # update day
    updated_date = random.randint(1, 28)
    
    # prevent the new date from going into the future
    if updated_year > 2022:
        updated_year = 2023
        updated_month = random.randint(month, 3) if year == 2023 else random.randint(1, 3)
        updated_date = random.randint(1, 3) if updated_month == 3 else random.randint(1, 28)

        if year == 2023:
            updated_year = 2023
            updated_month = random.randint(month, 3)
            updated_date = random.randint(day, 28) if updated_month == month else random.randint(1, 3) if updated_month == 3 else random.randint(1, 28)
        else:
            updated_year = 2023
            updated_month = random.randint(1, 3)
            updated_date = random.randint(1, 3) if updated_month == 3 else random.randint(1, 28)

    updated_time = f"{str(random.randint(0, 23)).zfill(2)}:{str(random.randint(0, 59)).zfill(2)}"
    df.loc[index, ['Updated At']] = f"{str(updated_month).zfill(2)}-{str(updated_date).zfill(2)}-{updated_year} {updated_time}"


# reset the index
df.reset_index(drop=True, inplace=True)

# check the dataframe and attribute types
print(df.head(10))
print(df.dtypes)

# save to a .csv file
df.to_csv('Dataset(Sanitized).csv', date_format=str)
