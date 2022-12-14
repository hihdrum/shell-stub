#!/bin/bash
#------------------------------------------------------------
# スタブシェル
#   呼び出された回数に応じて、設定した戻り値の返却と出力を行う。
#   呼び出された際の引数の個数と各引数をファイルに保持する。
#
#  呼び出し引数 : 任意
#------------------------------------------------------------

stubDir=$(dirname $0)

# 呼び出し回数情報
callcount=$(cat ${stubDir}/SHELLNAME.callcount)
callcountStr=$(echo ${callcount} | awk '{printf("%03d", $0 + 1)}')

#----------------------------------------
# 引数情報の保存
#----------------------------------------
# 個数情報
echo $# > "SHELLNAME.history${callcountStr}.argc"

# 各引数の情報
argIndex=1
for arg in "$@"
do
  historyFile="SHELLNAME.history${callcountStr}.arg${argIndex}"

  echo "${arg}" > ${historyFile}

  argIndex=$((argIndex + 1))

done

#----------------------------------------
# 実行時の戻り値取得と出力
#----------------------------------------
# 戻り値
expectReturnFile="${stubDir}/SHELLNAME.expect${callcountStr}.return"
returnValue=$(cat ${expectReturnFile})
if [ $? -ne 0 ]; then
  echo "戻り値を設定するファイル(${expectReturnFile}) がcatできませんでした。" >> $0.log
  exit 255
fi

# 標準出力
expectStdOutputFile="${stubDir}/SHELLNAME.expect${callcountStr}.stdout"
if [ -r ${expectStdOutputFile} ]; then
  cat ${expectStdOutputFile}
  if [ $? -ne 0 ]; then
    echo "標準出力を設定するファイル(${expectStdOutputFile}) がcatできませんでした。" >> $0.log
    exit 254
  fi
fi

expectStdErrOutputFile="${stubDir}/SHELLNAME.expect${callcountStr}.stderr"
if [ -r ${expectStdErrOutputFile} ]; then
  cat ${expectStdErrOutputFile} > /dev/stderr
  if [ $? -ne 0 ]; then
    echo "標準出力を設定するファイル(${expectStdErrOutputFile}) がcatできませんでした。" >> $0.log
    exit 254
  fi
fi


#----------------------------------------
# 情報の更新
#----------------------------------------
# 呼び出し回数情報
echo $((${callcount} + 1)) > ${stubDir}/SHELLNAME.callcount

# 戻り値
exit ${returnValue}

