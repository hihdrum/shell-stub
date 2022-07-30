#!/bin/bash

shellName=$1

dirPath=$(dirname $0)

cat ${dirPath}/template.sh | sed "s/SHELLNAME/${shellName}/g" > ${shellName}
cat ${dirPath}/template.clear.callcount | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.clear.callcount
cat ${dirPath}/template.set.expect | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.set.expect
cat ${dirPath}/template.set.expectOutput | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.set.expectOutput
cat ${dirPath}/template.reset | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.reset

chmod u+x ${shellName} ${shellName}.clear.callcount \
          ${shellName}.set.expect ${shellName}.set.expectOutput ${shellName}.reset

echo 0 > ${shellName}.callcount
