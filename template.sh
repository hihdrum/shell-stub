#!/bin/bash

stubDir=$(dirname $0)

# スクリプト呼び出し回数情報
callcount=$(cat ${stubDir}/SHELLNAME.callcount)
callcountStr=$(echo ${callcount} | awk '{printf("%03d", $0 + 1)}')

# 実行時の出力
expectOutputFile="${stubDir}/SHELLNAME.expectOutput${callcountStr}"

# 戻り値
expectFile="${stubDir}/SHELLNAME.expect${callcountStr}"

# 呼び出し引数の履歴保存
argIndex=1
for arg in "$@"
do
  historyFile="SHELLNAME.history${callcountStr}.arg${argIndex}"

  echo "${arg}" > ${historyFile}

  argIndex=$((argIndex + 1))

done

returnValue=$(cat ${expectFile})
if [ $? -ne 0 ]; then
  echo "戻り値を設定するファイル(${expectFile}) がcatできませんでした。" > /dev/stderr
  exit 255
fi

# 実行時の出力
cat ${expectOutputFile}
if [ $? -ne 0 ]; then
  echo "出力を設定するファイル(${expectOutputFile}) がcatできませんでした。" > /dev/stderr
  exit 254
fi

# 情報の更新
echo $((${callcount} + 1)) > ${stubDir}/SHELLNAME.callcount

# 結果
exit ${returnValue}
