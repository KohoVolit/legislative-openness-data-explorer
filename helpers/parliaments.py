# create parliaments.json

import json
import csv

with open("countries.json") as fin:
    countries = json.load(fin)

p = {}
i = 0
with open("source.csv") as fin:
    csvr = csv.reader(fin)
    for row in csvr:
        if i > 0:
            try:
                code = row[0]
                it = {
                    "name": row[11],
                    "country_name": countries[code]['name'],
                    "country_code": code,
                    "region": countries[code]['region'],
                    "id": str(i)
                }
                p[it['id']] = it
            except:
                print(code,row[11])
        i += 1

with open("parliaments.json","w") as fout:
    json.dump(p,fout)
