#!/bin/bash

callcount=$(cat a.callcount)
callcountStr=$(echo ${callcount} | awk '{printf("%03d", $0 + 1)}')

# 実行時の出力
expectOutputFile="a.expectOutput${callcountStr}"

# 戻り値
expectFile="a.expect${callcountStr}"

# 呼び出し引数の履歴
historyFile="a.history${callcountStr}.arg1"

# 呼び出し引数の保存
echo "$1" > ${historyFile}


returnValue=$(cat ${expectFile})

# 実行時の出力
cat ${expectOutputFile}

# 情報の更新
echo $((${callcount} + 1)) > a.callcount

# 結果
exit ${returnValue}
