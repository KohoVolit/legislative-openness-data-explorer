# create categories.json

import json
import csv

c = {}
i = 1
with open("categories.csv") as fin:
    csvd = csv.DictReader(fin)
    for row in csvd:
        c[row['code']] = row
        c[row['code']]['weight'] = i
        i += 1

with open("categories.json","w") as fout:
    json.dump(c,fout)
