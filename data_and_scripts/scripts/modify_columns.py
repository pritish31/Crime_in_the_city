import pandas as pd
import random

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 100)

df = pd.read_csv("buffalo_crime_v1.csv")

print(f"\nDF COLUMNS: {df.columns}")

neighborhoods = df['Neighborhood'].unique()
print(f"\nUnique Neighborhoods: {len(neighborhoods)}\n{neighborhoods}\n")

council_districts = df['Council District'].unique()
print(f"\nUnique Council Districts: {len(council_districts)}\n{council_districts}\n")


districts = dict()

for council_district in council_districts:
    districts[council_district] = []

i = 0
for district in districts.keys():
    districts[district].append(neighborhoods[i])
    districts[district].append(neighborhoods[i + 1])
    districts[district].append(neighborhoods[i + 2])
    if i > 31: break
    districts[district].append(neighborhoods[i + 3])
    i += 4

print(f"Districts dictionary: {districts}\n")


neighborhood_insert_values = list()
council_district_insert_values = list()

for _ in range(len(df)):
    random_council_dsitrict = random.choice(council_districts)
    council_district_insert_values.append(random_council_dsitrict)

    corresponding_neighborhood = random.choice(districts[random_council_dsitrict])
    neighborhood_insert_values.append(corresponding_neighborhood)


df.drop(columns=['Neighborhood', 'Council District'], inplace=True)

# insert new columns 'Neighborhood' and 'Council District'
df.insert(loc=7, column='Neighborhood', value=neighborhood_insert_values)
df.insert(loc=8, column='Council District', value=council_district_insert_values)


print(f"Number of columns: {len(df.columns)}")

print(df.columns)

print(df)

# save to a .csv file
df.to_csv('buffalo_crime_v2.csv', date_format=str)
