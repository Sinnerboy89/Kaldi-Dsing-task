#!/bin/sh

#  id2phone.R
#  
#
#  Created by Eleanor Chodroff on 3/24/15.
#
phones <- read.table("/home/chrisb/Kaldi-Dsing-task/DSing_Kaldi_Recipe/dsing/s5/data/lang/phones.txt", quote="\"")
ctm <- read.table("/home/chrisb/Kaldi-Dsing-task/DSing_Kaldi_Recipe/dsing/s5/merged_alignment.txt", quote="\"")

names(ctm) <- c("file_utt","utt","start","dur","id")
names(phones) <- c("phone","id")

ctm2 <- merge(ctm, phones, by="id")

write.table(ctm2, "/home/chrisb/Kaldi-Dsing-task/DSing_Kaldi_Recipe/dsing/s5/final_ali.txt", row.names=F, quote=F, sep="\t")