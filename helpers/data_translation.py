# extracts all texts from data for translation

import csv
import io
import git
import os
import requests
import settings

# languages settings
languages = ['en','fr']

# repo settings
repo = git.Repo(settings.git_dir)
git_ssh_identity_file = settings.ssh_file

# file within repo
tfile_name = '/data/texts.csv'

# source CSV settings:
subqn = 5 #row with subquestion number
subq = 6 # row with subquestion
q = 0 # row with questions
categ = 7 # row with categories
first = 10 # first other to be translated


# try:
#     tmp = os.path.realpath(__file__).split("/")
#     path = "/".join(tmp[:-1])
# except:
#     path = os.getcwd()

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

# update/pull from github
o = repo.remotes.origin
git_ssh_cmd = 'ssh -i %s' % git_ssh_identity_file
with repo.git.custom_environment(GIT_SSH_COMMAND=git_ssh_cmd):
    o.pull()


for lang in languages:
    ordered = []
    texts = {}
    url  = settings.raw_origin + lang + tfile_name
    r = requests.get(url)
    # r.encoding = 'utf-8'
    if r.status_code == 200:
        csvio = io.StringIO(r.text, newline="")
        for row in csv.reader(csvio):
            texts[row[0]] = row[1]
            ordered.append(row[0])

    i = 0
    url = settings.csv_url # url of the CSV
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
                        ordered.append(item)
        if i >= first:
            j = 0
            for item in row:
                if not columnfilter[j] == '':
                    if not is_number(item):
                        try:
                            texts[item]
                        except:
                            texts[item] = item
                            ordered.append(item)
                j += 1
        if i == subqn:
            columnfilter = row
        i += 1

    with open(settings.git_dir + lang + tfile_name,"w") as fout:
        csvw = csv.writer(fout)
        if ordered[0] != "code":
            csvw.writerow(["code","text"])
        for k in ordered:
            csvw.writerow([k,texts[k]])

    a = repo.git.add(settings.git_dir + lang + tfile_name)
    print(a)
    try:
        with repo.git.custom_environment(GIT_COMMITTER_NAME=settings.bot_name, GIT_COMMITTER_EMAIL=settings.bot_email):
            repo.git.commit(message="update data %s" % lang, author="%s <%s>" % (settings.bot_name, settings.bot_email))
        with repo.git.custom_environment(GIT_SSH_COMMAND=git_ssh_cmd):
            o.push()
    except Exception as e:
        print (e)
        nothing = 0
