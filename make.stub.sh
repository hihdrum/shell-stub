#!/bin/bash

shellName=$1

cat template.sh | sed 's/SHELLNAME/a/g' > ${shellName}.sh
cat template.clear.callcount | sed 's/SHELLNAME/a/g' > ${shellName}.clear.callcount
cat template.set.expect | sed 's/SHELLNAME/a/g' > ${shellName}.set.expect
cat template.set.expectOutput | sed 's/SHELLNAME/a/g' > ${shellName}.set.expectOutput
cat template.reset | sed 's/SHELLNAME/a/g' > ${shellName}.reset

chmod u+x ${shellName}.sh ${shellName}.clear.callcount \
          ${shellName}.set.expect ${shellName}.set.expectOutput ${shellName}.reset

echo 0 > ${shellName}.callcount
