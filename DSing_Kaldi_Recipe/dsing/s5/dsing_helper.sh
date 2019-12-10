# fresh start
rm -rvf data
rm -rvf exp
rm -rvf mfcc

./run.sh

# ensure permissions are set
chmod +x utils/prepare_lang.sh
chmod +x utils/fix_data_dir.sh
sudo chown chrisb data/srilm/best_4gram.gz
chmod +x utils/filter_scp.pl
chmod +x utils/utt2spk_to_spk2utt.pl
chmod +x utils/spk2utt_to_utt2spk.pl
chmod +x steps/make_mfcc.sh
chmod +x utils/validate_text.pl
chmod +x utils/create_data_link.pl
chmod +x utils/split_scp.pl

# remove hard run.pl and replace with soft-link to parallel version
cd utils
rm -v run.pl
ln -s parallel/run.pl run.pl

# more permissions
chmod +x steps/compute_cmvn_stats.sh
chmod +x steps/train_mono.sh
chmod +x utils/data/get_utt2dur.sh
chmod +x utils/data/internal/modify_speaker_info.py
chmod +x utils/filter_scps.pl
chmod +x steps/diagnostic/analyze_alignments.sh
chmod +x utils/summarize_warnings.pl
chmod +x steps/info/gmm_dir_info.pl
chmod +x steps/align_si.sh
chmod +x steps/decode_fmllr.sh
chmod +x steps/diagnostic/analyze_alignments.sh
chmod +x utils/lang/check_phones_compatible.sh
chmod +x steps/train_deltas.sh
chmod +x steps/train_lda_mllt.sh
chmod +x steps/train_sat.sh
chmod +x steps/decode.sh
chmod +x steps/cleanup/clean_and_segment_data.sh
chmod +x local/chain/run_tdnn_1d.sh
chmod +x steps/diagnostic/analyze_lats.sh
chmod +x steps/scoring/score_kaldi_wer.sh
chmod +x utils/sym2int.pl


# ---------------------------------
# -------- Align new data ---------
# ---------------------------------


# one-time setup
ln -s /home/chrisb/kaldi/src /home/chrisb/Kaldi-Dsing-task/DSing_Kaldi_Recipe/dsing/s5/src
mkdir -p data/alignme

# create text, segments, wav.scp, utt2spk (manually, for now)

# setup
export nj=1
export mfccdir=mfcc
model=tri3b

# clean run
rm -rv data/alignme/split*
rm -rv data/alignme/conf
rm -rv data/alignme/.backup
rm -v mfcc/*alignme*
rm -rv exp/*alignme*

# generate MFCCs
for x in data/alignme
do
    steps/make_mfcc.sh $x exp/make_mfcc/$x $mfccdir
    utils/fix_data_dir.sh data/alignme
    steps/compute_cmvn_stats.sh $x exp/make_mfcc/$x $mfccdir
    utils/fix_data_dir.sh data/alignme
done

# align
steps/align_si.sh data/alignme data/lang_3G exp/$model exp/$model'_alignme'

# extract alignment and concatenate
for i in  exp/$model'_alignme'/ali.*.gz; do 
    src/bin/ali-to-phones --ctm-output exp/$model/final.mdl ark:"gunzip -c $i|" -> ${i%.gz}.ctm;
done
cat exp/$model'_alignme'/*.ctm > merged_alignment.txt

# convert phone ID to phone
Rscript id2phone.R

# split by file
python splitAlignments.py