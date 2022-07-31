#!/bin/bash

# 本ディレクトリに shunit2 を用意して下さい。

oneTimeSetUp() {
  rm -rf stub
  mkdir stub
  pushd stub > /dev/null
  ../../make.stub.sh sample.sh
  popd > /dev/null

  PATH=$(pwd):$PATH
}

test_callcount_0To0() {
  echo 0 > stub/sample.sh.callcount
  sample.sh.clear.callcount
  assertEquals 0 $(cat stub/sample.sh.callcount)
}

test_callcount_1To0() {
  echo 1 > stub/sample.sh.callcount
  sample.sh.clear.callcount
  assertEquals 0 $(cat stub/sample.sh.callcount)
}

# Load shuUnit2.
. ./shunit2

