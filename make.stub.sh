#!/bin/bash

shellName=$1

dirPath=$(dirname $0)

cat ${dirPath}/template.sh | sed "s/SHELLNAME/${shellName}/g" > ${shellName}
cat ${dirPath}/template.clear.callcount | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.clear.callcount
cat ${dirPath}/template.set.expect.return | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.set.expect.return
cat ${dirPath}/template.set.expect.output | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.set.expect.output
cat ${dirPath}/template.reset | sed "s/SHELLNAME/${shellName}/g" > ${shellName}.reset

chmod u+x ${shellName} ${shellName}.clear.callcount \
          ${shellName}.set.expect.return ${shellName}.set.expect.output ${shellName}.reset

echo 0 > ${shellName}.callcount
