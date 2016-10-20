#!/usr/bin/env bash

ASR_RUN_DIR="/home/xiaoweiw/research/lucida/lucida/lucida/speechrecognition/kaldi_gstreamer_asr/"
ASR_INPUT_DIR="/home/xiaoweiw/research/lucida/lucida/lucida/speechrecognition/kaldi_gstreamer_asr/test/data/standard/"
ASR_RET_DIR="/home/xiaoweiw/research/lucida/AIE/exp/asr/out/"
ASR_DEF_OUT="/home/xiaoweiw/research/lucida/lucida/lucida/speechrecognition/kaldi_gstreamer_asr/test/data/asr_out.txt"

QA_RUN_DIR="/home/xiaoweiw/research/lucida/lucida/lucida/questionanswering/OpenEphyra/"
QA_DEF_IN="/home/xiaoweiw/research/lucida/lucida/lucida/questionanswering/OpenEphyra/src/lucida/test/data/qa_in.txt"
QA_DEF_OUT="/home/xiaoweiw/research/lucida/lucida/lucida/questionanswering/OpenEphyra/src/lucida/test/data/qa_out.txt"
QA_RET_DIR="/home/xiaoweiw/research/lucida/AIE/exp/qa/out/"

for vq_in in ${ASR_INPUT_DIR}/*.wav; do
  vq_name=$(basename ${vq_in})
  vq_name="${vq_name%.*}"
  cd $ASR_RUN_DIR
  ./testing.sh ${vq_in}
  mv ${ASR_DEF_OUT} ${ASR_RET_DIR}/${vq_name}.asr.out
  sleep 1
  cd $QA_RUN_DIR
  cp ${ASR_RET_DIR}/${vq_name}.asr.out ${QA_DEF_IN}
  ./start_test.sh
  mv ${QA_DEF_OUT} ${QA_RET_DIR}/${vq_name}.qa.out
  sleep 1
done
