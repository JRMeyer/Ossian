#!/bin/bash

# exit if script crashes
set -e
export lang=C.UTF-8

lang=chv
voice=news
recipe=naive_01_nn

# mkdir -p ~/Ossian/test/txt ~/Ossian/test/wav
# echo 'кандайсыз байке!' > ~/Ossian/test/txt/${lang}.txt


# echo "### BEGIN TRAIN OSSIAN ###"

# python ./scripts/train.py -s ${voice} -l ${lang} ${recipe} || exit 1; 

# echo "### END TRAIN OSSIAN ###"



echo "### BEGIN TRAIN MERLIN ###"

export THEANO_FLAGS=""

python ./tools/merlin/src/run_merlin.py \
       /home/ubuntu/Ossian/train/${lang}/speakers/${voice}/${recipe}/processors/duration_predictor/config.cfg \
    || exit 1;

python ./tools/merlin/src/run_merlin.py \
       /home/ubuntu/Ossian/train/${lang}/speakers/${voice}/${recipe}/processors/acoustic_predictor/config.cfg \
    || exit 1;

echo "### END TRAIN MERLIN ###"



echo "### BEGIN CONVERT MERLIN ###"

python ./scripts/util/store_merlin_model.py \
       /home/ubuntu/Ossian/train/${lang}/speakers/${voice}/${recipe}/processors/duration_predictor/config.cfg \
       /home/ubuntu/Ossian/voices/${lang}/${voice}/${recipe}/processors/duration_predictor \
    || exit 1;

python ./scripts/util/store_merlin_model.py \
       /home/ubuntu/Ossian/train/${lang}/speakers/${voice}/${recipe}/processors/acoustic_predictor/config.cfg \
       /home/ubuntu/Ossian/voices/${lang}/${voice}/${recipe}/processors/acoustic_predictor\
    || exit 1;

echo "### END CONVERT MERLIN ###"



# echo "ALL DONE TRAINING MERLIN + OSSIAN"


# echo "### BEGIN SYNTHESIZE ###"
 
# python ./scripts/speak.py \
#        -l $lang \
#        -s $voice \
#        -o test/wav/${lang}_test.wav \
#        ${recipe} \
#        test/txt/${lang}.txt \
#     || exit 1;
 
