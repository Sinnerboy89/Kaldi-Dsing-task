import sys, re, glob, os
import numpy as np

def sortbyStart(val): 
    return float(val[3])

ali = [x.split('\t') for x in open("final_ali.txt", 'r').readlines()]
ali = ali[1:]
ali.sort(key = sortbyStart)
utt_list = list(dict.fromkeys([x[1] for x in ali]))

for utt in utt_list:
    with open(utt + ".lab", 'w') as utt_file:
        for al in ali:
            if utt == al[1]:
                start = al[3]
                end = str(float(start) + float(al[4]))
                phone = al[5].lower().replace('\n', '')
                mid = float(start) + float(end) / 2.
                word = "word"
                utt_file.write("%s %s %s %g %s 0 0\n" % (start, end, phone, mid, word))

pron_ali = open("pron_alignment.txt",'w')
pron=[]
files = glob.glob('*.lab')

# process each file
for filei in files:
    f = open(filei, 'r')
    pron_ali.write('\n')
    for line in f:
        line = line.split(" ")
        phon_pos = line[2]
        if phon_pos == "sil":
            phon_pos = "sil_s"
        phon_pos = phon_pos.split("_")
        phon = phon_pos[0]
        pos = phon_pos[1]
        if pos == "b":
            start = line[0]
            pron.append(phon)
        if pos == "s":
            start = line[0]
            end = line[1]
            pron.append(phon)
            pron_ali.write(filei + '\t' + ' '.join(pron) +'\t'+ str(start) + '\t' + str(end))
            pron = []
        if pos == "e":
            end = line[1]
            pron.append(phon)
            pron_ali.write(filei + '\t' + ' '.join(pron) +'\t'+ str(start) + '\t' + str(end))
            pron = []
        if pos == "i":
            pron.append(phon)

pron_ali.close()

# import csv, codecs

# # make dictionary of word: prons
# lex = {}

# with codecs.open("lexicon.txt", "rb", "utf-8") as f:
#     for line in f:
#         line = line.strip()
#         columns = line.split("\t")
#         word = columns[0]
#         pron = columns[1]
#         #print pron
#         try:
#             lex[pron].append(word)
#         except:
#             lex[pron] = list()
#             lex[pron].append(word)

# # open file to write

# word_ali = codecs.open("word_alignment.txt", "wb", "utf-8")

# # read file with most information in it
# with codecs.open("pron_alignment.txt", "rb", "utf-8") as f:
#     for line in f:
#         line = line.strip()
#         line = line.split("\t")
#         # get the pronunciation
#         pron = line[1]
#         # look up the word from the pronunciation in the dictionary
#         word = lex.get(pron)
#         word = word[0]
#         file = line[0]
#         start = line[2]
#         end = line[3]
#         word_ali.write(file + '\t' + word + '\t' + start + '\t' + end + '\n')
