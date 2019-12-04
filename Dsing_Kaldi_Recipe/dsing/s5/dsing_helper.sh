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
