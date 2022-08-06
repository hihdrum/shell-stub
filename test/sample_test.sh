#!/bin/bash

# 本ディレクトリに shunit2 を用意して下さい。

oneTimeSetUp() {
  mkdir stub.$$
  pushd stub.$$ > /dev/null
  ../../make.stub.sh sample.sh
  PATH=$(pwd):$PATH
  popd > /dev/null
}

setUp() {
  sample.sh.init
}

tearDown() {
  if [ -e stub.$$ ]; then
    sample.sh.rm.history
  fi
}

testReturnValue_times1() {

  sample.sh.set.expect 1 0 ""

  sample.sh
  ret=$?

  assertEquals 0 ${ret}
}

testoutput_times1() {

  sample.sh.set.expect 1 0 "ABC"

  output=$(sample.sh)

  assertEquals "ABC" ${output}
}

testReturnValue_times2() {

  sample.sh.set.expect 1 0 ""
  sample.sh.set.expect 2 10 ""

  sample.sh
  ret1=$?

  sample.sh
  ret2=$?

  assertEquals 0 ${ret1}
  assertEquals 10 ${ret2}
}

testoutput_times2() {

  sample.sh.set.expect 1 0 "ABC"
  sample.sh.set.expect 2 0 "DEF"

  output1=$(sample.sh)
  output2=$(sample.sh)

  assertEquals "ABC" ${output1}
  assertEquals "DEF" ${output2}
}

testoutput_std2line() {
  sample.sh.set.expect 1 0
  echo -e "ABC\nDEF" > $(sample.sh.get.expect.stdout.path 1)

  sample.sh > resultOut
  diff <(echo -e "ABC\nDEF") resultOut
  ret=$?

  assertEquals 0 ${ret}

  rm -f resultOut
}

testoutput_stdErr2line() {
  sample.sh.set.expect 1 0
  echo -e "ABC\nDEF" > $(sample.sh.get.expect.stderr.path 1)

  sample.sh 2> resultOut
  diff <(echo -e "ABC\nDEF") resultOut
  ret=$?

  assertEquals 0 ${ret}

  rm -f resultOut
}

testoutput_stdout_stdErr() {
  sample.sh.set.expect 1 0
  echo -e "ABC\nDEF" > $(sample.sh.get.expect.stdout.path 1)
  echo -e "HIJ\nLMN" > $(sample.sh.get.expect.stderr.path 1)

  sample.sh > resultStdout 2> resultStderr
  diff <(echo -e "ABC\nDEF") resultStdout
  diff <(echo -e "HIJ\nLMN") resultStderr
  ret=$?

  assertEquals 0 ${ret}

  rm -f resultStdout
  rm -f resultStderr
}

# Load shuUnit2.
. ./shunit2

# テストスクリプトのTearDown
# oneTimeTeaDownに記述すると上手く行かないので
# ここで行う。
rm -rf stub.$$

