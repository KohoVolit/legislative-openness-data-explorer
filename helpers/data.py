# create data.json

c2id = {}   #column 2 id
questions = {}
data = {}
options = {}
exceptions = [6,7,10,13,16,18,20,24,27,30,33,36,39,41,48,51,105,187, 219,235,416,435,444,748,764]  #also contain options, not texts
with open("source.csv") as fin:
    csvr = csv.reader(fin)
    i = 0   #row
    k = -1  #question_id
    for row in csvr:
        if i == 0:
            j = 1   #column
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
            it = {}
            for item in row:
                
                try:
                    it[c2id[j]]
                except:
                    it[c2id[j]] = {'options':[],'texts':[]}
                if item.strip() != '':
                    if j in exceptions:
                        it[c2id[j]]['options'].append(item.strip())
                        try:
                            options[c2id[j]]
                        except:
                            options[c2id[j]] = {}
                        options[c2id[j]][item] = item
                    else:
                        try:
                            it[c2id[j]]['options'].append(options[c2id[j]][item.strip()])
                        except:
                            it[c2id[j]]['texts'].append(item.strip())
#                   
                j += 1
            data[i] = it
            
        i += 1


#raise(Exception)

o2value = {}
with open("os.csv") as fin:
    csvr = csv.DictReader(fin)
    for row in csvr:
        try:
            o2value[int(row['question_id'])]
        except:
            o2value[int(row['question_id'])] = {}
        if row['value'] != '':
            o2value[int(row['question_id'])][row['option']] = int(row['value'])


for kee in data:
    row = data[kee]
    for key in row:
        value = ''
        for o in row[key]['options']:
            try:
                if value == '':
                    value = o2value[key][o]
                    raise(Exception)
                else:
                    if value > o2value[key][o]:
                        value = o2value[key][o]
            except:
                nothing = 0
        row[key]['value'] = value
        row[key]['question_id'] = key
        row[key]['parliament_id'] = kee

with open("data.json","w") as fout:
    json.dump(data,fout)   
