#!/bin/bash


callcount=$(cat a.callcount | awk '{printf("%03d", $0 + 1)}')

expectFile="a.expect${callcount}"
returnValue=$(cat ${expectFile})

exit ${returnValue}
