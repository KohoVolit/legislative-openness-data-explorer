# read source  .csv from google sheet and produce json with data

import csv
import io
import json
import os
import requests

c2p = 992   #ids of parliaments
first = 10  #row with first parliament

url = "https://docs.google.com/spreadsheets/d/13ZfbbrUsl-ZwLdUWD9topnkrwCWSNOfPC2YIb0eWNc4/pub?output=csv" #url of the CSV

try:
    tmp = os.path.realpath(__file__).split("/")
    path = "/".join(tmp[:-1])
except:
    path = os.getcwd()

data = {}

# value for questions with some logic (based on their question ID):
def get_value(qid,dicti):
    qid = int(qid)
    if qid in [1,2,3,5,6,10,21]:
        li = dicti['1']
        if 'No' in li:
            return 3
        if 'Yes' in li:
            return 1
        else:
            return 0

    if qid in [4]:
        li = dicti['1']
        if 'No' in li:
            return 1
        if 'Yes' in li:
            return 3
        else:
            return 0

    if qid == 7:
        if dicti['1'][0] == 'N/A':
            return 0
        if dicti['1'][0] != '' and dicti['1'][1] != '':
            return 1
        if dicti['1'][0] != '' or dicti['1'][1] != '':
            return 2
        return 3

    if qid == 8:
        if dicti['1'][0] != '' or dicti['1'][1] != '':
            return 1
        if dicti['1'][2] != '':
            return 2
        if dicti['1'][4] != '':
            return 0
        return 3

    if qid == 9:
        s = 0
        for it in dicti['1'][0:7]:
            if it != '':
                s += 1
        if s >= 3:
            return 1
        if s > 0:
            return 2
        return 3

    if qid == 11:
        s = 0
        for it in dicti['1'][0:3]+dicti['1'][5:10]:
            if it != '':
                s += 1
        if s >= 5:
            return 1
        if s > 0:
            return 2
        return 3


    if qid in [14,12,13,15,17,18,19,20,22,23,24,27,28,29,30,31,32,33,34, 35,36,37,38,39,40,41,42,43,44,45,46,47,48]:
        li = dicti['1']
        i = 0
        for it in li:
            li[i] = it.strip()
            i += 1
        if 'Yes, online' in li or 'Yes, offline' in li:
            return 1
        if 'No' in li:
            return 3
        else:
            return 0

    if qid in [16]:
        s = 0
        for it in dicti['1'][0:5]:
            if it != '':
                s += 1
        if s >= 3:
            return 1
        if s > 0:
            return 2
        if dicti['1'][6] != '':
            return 0
        return 3

    if qid == 26:
        s = 0
        for it in dicti['1'][0:5]:
            if it != '':
                s += 1
        if s >= 3:
            return 1
        if s > 0:
            return 2
        return 3

r = requests.get(url)
r.encoding = 'utf-8'
csvio = io.StringIO(r.text, newline="")
i = 0
for row in csv.reader(csvio):
    if i == 3:
        qidrow = row
    if i == 4:
        qidsrow = row
    if i == 5:
        sidsrow = row

    if i >= first:
        localdata = {}
        j = 0
        for item in row:
            if qidsrow[j] != "" and j>0:
                try:
                    localdata[qidsrow[j]]
                except:
                    localdata[qidsrow[j]] =  {'value':0,'subquestions': {}}
                try:
                    localdata[qidsrow[j]]['subquestions'][sidsrow[j]]
                except:
                    localdata[qidsrow[j]]['subquestions'][sidsrow[j]] = []
                localdata[qidsrow[j]]['subquestions'][sidsrow[j]].append(item)
            j += 1
        for k1 in localdata:
            for k2 in localdata[k1]['subquestions']:
                localdata[k1]['value'] = get_value(k1,localdata[k1]['subquestions'])
        data[row[c2p-1]] = localdata
    i += 1

with open(path + "/data.json","w") as fout:
    json.dump(data,fout)
