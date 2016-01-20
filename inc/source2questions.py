# read source  .csv from google sheet and produce json with questions

import csv
import io
import json
import os
import requests

questions = {}

tmp = os.path.realpath(__file__).split("/")
path = "/".join(tmp[:-1])

url = "https://docs.google.com/spreadsheet/ccc?key=1iABzv1hjXP0Ky9Jm_tggyfLzU_B0s0RiCy_nOkGBMAg&output=csv" #url of the CSV

with open(path + "/categories.json") as fin:
    categories = json.load(fin)

i = 0
r = requests.get(url)
csvio = io.StringIO(r.text, newline="")
for row in csv.reader(csvio):
    if i == 0:
        qrow = row
    if i == 3:
        qidrow = row
    if i == 4:
        qidsrow = row
    if i == 5:
        sidsrow = row
    if i == 6:
        srow = row
    if i == 7:
        crow = row
    i += 1
        

def text2cats(w,categories):
    out = {"names":[],"codes":[],"icons":[]}
    li = w.split(',')
    weight = 10000
    for r in li:
        out["names"].append(r.strip())
        out["codes"].append(r.strip().lower().replace(' ','-'))
        out["icons"].append(categories[r.strip().lower().replace(' ','-')]['icon'])
        if categories[r.strip().lower().replace(' ','-')]['weight'] < weight:
            weight = categories[r.strip().lower().replace(' ','-')]['weight']
    out['weight'] = weight 
    return out

j = 0
for r in qidsrow:
    if not r.strip() == "":
        try:
            questions[r]
        except:
            questions[r] = {}
        questions[r]['id'] = r
        try:
            questions[r]['subquestions']
        except:
            questions[r]['subquestions'] = {}
        try:
            questions[r]['subquestions'][sidsrow[j]]
        except:
            questions[r]['subquestions'][sidsrow[j]] = {}
        questions[r]['subquestions'][sidsrow[j]]['id'] = sidsrow[j]
        questions[r]['subquestions'][sidsrow[j]]['subquestion'] = srow[j]
        if qidrow[j] != "" and j>0:
            questions[r]['categories'] = text2cats(crow[j],categories)
            questions[r]['category_weight'] = questions[r]['categories']['weight']
            questions[r]['question'] = qrow[j].strip()
    j += 1
    
with open(path + "/questions.json","w") as fout:
    json.dump(questions,fout)       
