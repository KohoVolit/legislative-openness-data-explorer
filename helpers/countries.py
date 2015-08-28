# create countries.json

import csv
import json

countries = {}
with open("countries.csv") as fin:
    csvd = csv.DictReader(fin)
    for row in csvd:
        countries[row['id']] = row

with open("regions2.csv") as fin:
    csvd = csv.DictReader(fin)
    for row in csvd:
        try:
            code = row["alpha-2"].lower()
            countries[code]['code'] = code
            countries[code]['name'] = row['name']
            countries[code]['region'] = row['region']
            countries[code]['sub-region'] = row['sub-region']
        except:
            print(row["alpha-2"].lower())

with open("countries.json","w") as fout:
    json.dump(countries,fout)
