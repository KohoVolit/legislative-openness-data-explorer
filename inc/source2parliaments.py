# create parliaments.json

import csv
import io
import json
import os
import requests
#import settings

try:
    tmp = os.path.realpath(__file__).split("/")
    path = "/".join(tmp[:-1])
except:
    path = os.getcwd()

url = "https://docs.google.com/spreadsheets/d/13ZfbbrUsl-ZwLdUWD9topnkrwCWSNOfPC2YIb0eWNc4/pub?output=csv" # url of the CSV

c2p = 992   #ids of parliaments
c2c = 993   # codes of countries
first = 10  # row with first parliament
c2name = 16 # names of parliament

with open(path + "/countries.json") as fin:
    countries = json.load(fin)

p = {}
i = 0
r = requests.get(url)
r.encoding = 'utf-8'
csvio = io.StringIO(r.text, newline="")
for row in csv.reader(csvio):
    if i >= first:
        try:
            code = row[c2c-1]
            it = {
                "name": row[c2name - 1],
                "country": countries[code]['name'],
                "country_code": code,
                "region": countries[code]['region'],
                "id": str(row[c2p-1])
            }
            p[it['id']] = it
        except:
            print(code,row[c2name - 1])
    i += 1

with open(path + "/parliaments.json","w") as fout:
    json.dump(p,fout)
