#!/bin/bash

# 感情値の初期化
enjoy_val=0
happy_val=0
like_val=0
relief_val=0
surprise_val=0

usage_exit() {
  echo "Usage: $0 [-f] filename" 1>&2
  exit 1
}

file_check() {
  if [ $? == 1 ]; then
    echo $filename"が存在しません。"
    exit 1
  fi
}

while getopts :f OPT
do
  case $OPT in
    f) FILE_FLAG=1
      ;;
    \?) usage_exit
      ;;
  esac
done

# 区切り文字をカンマに設定
IFS=','

# 辞書の存在チェック、代入
filename="enjoy.csv"
enjoy_dic=(`cat $filename 2> /dev/null`)
file_check $*

filename="happy.csv"
happy_dic=(`cat $filename 2> /dev/null`)
file_check $*

filename="like.csv"
like_dic=(`cat $filename 2> /dev/null`)
file_check $*

filename="relief.csv"
relief_dic=(`cat $filename 2> /dev/null`)
file_check $*

filename="surprise.csv"
surprise_dic=(`cat $filename 2> /dev/null`)
file_check $*

# mecabで分ち書きにしたものを配列に代入
IFS=' '
word_list=(`echo $1 | mecab -Owakati`)

# 比較処理
for word in "${word_list[@]}"; do
  # enjoyのカウント
  for enjoy_word in "${enjoy_dic[@]}"; do
    if [ $word == $enjoy_word ]; then
      (( enjoy_val++ ))
    fi
  done

  # happyのカウント
  for happy_word in "${happy_dic[@]}"; do
    if [ $word == $happy_word ]; then
      (( happy_val++ ))
    fi
  done

  # likeのカウント
  for like_word in "${like_dic[@]}"; do
    if [ $word == $like_word ]; then
      (( like_val++ ))
    fi
  done

  # reliefのカウント
  for relief_word in "${relief_dic[@]}"; do
    if [ $word == $relief_word ]; then
      (( relief_val++ ))
    fi
  done

  # surpriseのカウント
  for surprise_word in "${surprise_dic[@]}"; do
    if [ $word == $surprise_word ]; then
      (( surprise_val++ ))
    fi
  done
done

echo "enjoy:"$enjoy_val
echo "happy:"$happy_val
echo "like:"$like_val
echo "relief:"$relief_val
echo "surprise:"$surprise_val
