# extracts all texts from data for translation

import csv
import io
import os
import requests
from github import Github
import authentication

languages = ['es']

try:
    tmp = os.path.realpath(__file__).split("/")
    path = "/".join(tmp[:-1])
except:
    path = os.getcwd()



subqn = 5 #row with subquestion number
subq = 6 # row with subquestion
q = 0 # row with questions
categ = 7 # row with categories
first = 10 # first other to be translated

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

g = Github(authentication.name, authentication.password)
repo_name = "KohoVolit/legislative-openness-data-explorer-texts/"
repo_local = ""

for lang in languages:
    texts = {}
    url  = 'https://raw.githubusercontent.com/KohoVolit/legislative-openness-data-explorer-texts/master/' + lang + '/data/texts.csv'
    r = requests.get(url)
    # r.encoding = 'utf-8'
    if r.status_code == 200:
        csvio = io.StringIO(r.text, newline="")
        for row in csv.reader(csvio):
            texts[row[0]] = row[1]

    i = 0
    url = "https://docs.google.com/spreadsheets/d/13ZfbbrUsl-ZwLdUWD9topnkrwCWSNOfPC2YIb0eWNc4/pub?output=csv" # url of the CSV
    r = requests.get(url)
    r.encoding = 'utf-8'
    csvio = io.StringIO(r.text, newline="")
    for row in csv.reader(csvio):
        if i in [subq,q,categ]:
            for item in row:
                if not is_number(item):
                    try:
                        texts[item]
                    except:
                        texts[item] = item
        if i >= first:
            j = 0
            for item in row:
                if not columnfilter[j] == '':
                    if not is_number(item):
                        try:
                            texts[item]
                        except:
                            texts[item] = item
                j += 1
        if i == subqn:
            columnfilter = row
        i += 1

    with open(path + "/texts_" + lang + ".csv","w") as fout:
        csvw = csv.writer(fout)
        for k in texts:
            csvw.writerow([k,texts[k]])
