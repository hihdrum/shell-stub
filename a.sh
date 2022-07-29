#!/bin/bash

callcount=$(cat a.callcount)
callcountStr=$(echo ${callcount} | awk '{printf("%03d", $0 + 1)}')

expectFile="a.expect${callcountStr}"
returnValue=$(cat ${expectFile})

# 情報の更新
echo $((${callcount} + 1)) > a.callcount

# 結果
exit ${returnValue}
