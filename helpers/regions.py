import csv
import json

with open("all.json") as fin:
    countries = json.load(fin)

r = {}
with open("regions.csv") as fin:
    csvr = csv.reader(fin)
    for row in csvr:
        r[row[0]] = row[1]

for country in countries:
    try:
        country['sub-region'] = r[country['sub-region-code']]
        country['region'] = r[country['region-code']]
    except:
        print(country)
    
    
with open("regions.json","w") as fout:
    json.dump(countries,fout)

with open("regions2.csv","w") as fout:
    csvw = csv.writer(fout)
    csvw.writerow(["name","alpha-2","alpha-3","country-code","iso_3166-2","region-code","sub-region-code","region","sub-region"])
    for r in countries:
        try:
            row = [r["name"],r["alpha-2"],r["alpha-3"],r["country-code"],r["iso_3166-2"],r["region-code"],r["sub-region-code"],r["region"],r["sub-region"]]
        except:
            row = [r["name"],r["alpha-2"],r["alpha-3"],r["country-code"],r["iso_3166-2"],"","","",""]
        csvw.writerow(row)
        
    
