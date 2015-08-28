# create questions.json

import json
import csv

with open("categories.json") as fin:
    categories = json.load(fin)

q = {}
i = 0
with open("qs.csv") as fin:
    csvd = csv.DictReader(fin)
    for row in csvd:
        code = row['id']
        it = row
        if row['category_code'] != '':
            it['category_icon'] = categories[row['category_code']]['icon']
            it['category_weight'] = categories[row['category_code']]['weight']
            it['category_name'] = categories[row['category_code']]['name']
        else:
            it['category_icon'] = ""
            it['category_weight'] = ""
            it['category_name'] = ""
        if it['weight'] == "":
            it['weight'] = 1000000
        q[row['id']] = it

with open("questions.json","w") as fout:
    json.dump(q,fout)
            
