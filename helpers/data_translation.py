# extracts all texts from data for translation

import csv
import io
import os
import requests

try:
    tmp = os.path.realpath(__file__).split("/")
    path = "/".join(tmp[:-1])
except:
    path = os.getcwd()

url = "https://docs.google.com/spreadsheets/d/13ZfbbrUsl-ZwLdUWD9topnkrwCWSNOfPC2YIb0eWNc4/pub?output=csv" # url of the CSV

subqn = 5 #row with subquestion number
subq = 6 # row with subquestion
q = 0 # row with questions
categ = 7 # row with categories
first = 10 # first other to be translated

texts = {}

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

i = 0
r = requests.get(url)
r.encoding = 'utf-8'
csvio = io.StringIO(r.text, newline="")
for row in csv.reader(csvio):
    if i in [subq,q,categ]:
        for item in row:
            if not is_number(item):
                texts[item] = item
    if i >= first:
        j = 0
        for item in row:
            if not columnfilter[j] == '':
                if not is_number(item):
                    texts[item] = item
            j += 1
    if i == subqn:
        columnfilter = row
    i += 1

with open(path + "/data_texts.csv","w") as fout:
    csvw = csv.writer(fout)
    for k in texts:
        csvw.writerow([k,k])
