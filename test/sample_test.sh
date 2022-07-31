#!/bin/bash

# 本ディレクトリに shunit2 を用意して下さい。

oneTimeSetUp() {
  rm -rf stub
  mkdir stub
  pushd stub > /dev/null
  ../../make.stub.sh sample.sh
  popd > /dev/null

  PATH=$(pwd)/stub:$PATH
}

# oneTimeTearDownが最後のテストのtearDownよりも前に実行されるようなので、
# この位置にstub削除は書けない。
#oneTimeTearDown() {
#  rm -rf stub
#}

setUp() {
  sample.sh.init
}

tearDown() {
  sample.sh.rm.history
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

