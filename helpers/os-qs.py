# read source.csv and produce json

import csv
import json

c2id = {}   #column 2 id
questions = {}
data = []
options = {}
exceptions = [6,7,10,13,16,18,20,24,27,30,33,36,39,41,48,51,105,187, 219,235,416,435,444,748,764]  #also contain options, not texts
with open("source.csv") as fin:
    csvr = csv.reader(fin)
    i = 0
    k = -1
    for row in csvr:
        if i == 0:
            j = 1
            for item in row:
                itemli = item.split(':')
                if len(itemli)>2:
                    question = ':'.join(itemli[1:])
                else:
                    question = itemli[len(itemli)-1]
                try:
                    questions[question]
                except:
                    k += 1
                    questions[question] = k                
                c2id[j] = k
                
                if len(itemli) > 1:
                    try:
                        options[k]
                    except:
                        options[k] = {}
                    options[k][itemli[0]] = itemli[0]
                
                j += 1
        else:
            j = 1
            it = {'id':i, 'data': {}}
            for item in row:
                
                try:
                    it['data'][c2id[j]]
                except:
                    it['data'][c2id[j]] = {'options':[],'texts':[]}
                if item.strip() != '':
                    if j in exceptions:
                        it['data'][c2id[j]]['options'].append(item.strip())
                        try:
                            options[c2id[j]]
                        except:
                            options[c2id[j]] = {}
                        options[c2id[j]][item] = item
                    else:
                        try:
                            it['data'][c2id[j]]['options'].append(options[c2id[j]][item.strip()])
                        except:
                            it['data'][c2id[j]]['texts'].append(item.strip())
#                   
                j += 1
            data.append(it)
            
        i += 1
        
# qs[1] = 'sample question?'
# question['sample question?'] = 1
qs = {}
for key in questions:
    qs[questions[key]] = key

with open("questions.csv","w") as fout:
    csvw = csv.writer(fout)
    for k in sorted(qs):
        csvw.writerow([k,qs[k]])

with open("options.csv","w") as fout:
    csvw = csv.writer(fout)
    for k in sorted(options):
        for key in options[k]:
            csvw.writerow([k,key,qs[k]])

###
### create os.csv manually (from options.csv)
###

###
### create qs.csv manually (from questions.csv)
###
