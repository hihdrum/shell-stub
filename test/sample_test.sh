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

# Load shuUnit2.
. ./shunit2

# テストスクリプトのTearDown
rm -rf stub.$$

