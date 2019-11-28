# fresh start
rm -rv data

./run.sh

# ensure permissions are set
chmod +x utils/prepare_lang.sh
chmod +x utils/fix_data_dir.sh
sudo chown chrisb data/srilm/best_4gram.gz
chmod +x utils/filter_scp.pl
chmod +x utils/utt2spk_to_spk2utt.pl
chmod +x utils/spk2utt_to_utt2spk.pl
chmod +x steps/make_mfcc.sh