#!/bin/bash

shellName=$1

dirPath=$(dirname $0)

cat ${dirPath}/template.sh | sed "s/SHELLNAME/${shellName}/g" > ${shellName}
cat ${dirPath}/template.clear.callcount | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.clear.callcount
cat ${dirPath}/template.set.expect | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.set.expect
cat ${dirPath}/template.init | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.init
cat ${dirPath}/template.rm.history | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.rm.history

chmod u+x ${shellName} ${shellName}.clear.callcount \
          ${shellName}.set.expect ${shellName}.init \
          ${shellName}.rm.history

echo 0 > ${shellName}.callcount
