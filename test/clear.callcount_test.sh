#!/bin/bash

# 本ディレクトリに shunit2 を用意して下さい。

oneTimeSetUp() {
  mkdir stub.$$
  pushd stub.$$ > /dev/null
  ../../make.stub.sh sample.sh
  PATH=$(pwd):$PATH
  popd > /dev/null
}

test_callcount_0To0() {
  echo 0 > stub.$$/sample.sh.callcount
  sample.sh.clear.callcount
  assertEquals 0 $(cat stub.$$/sample.sh.callcount)
}

test_callcount_1To0() {
  echo 1 > stub.$$/sample.sh.callcount
  sample.sh.clear.callcount
  assertEquals 0 $(cat stub.$$/sample.sh.callcount)
}

# Load shuUnit2.
. ./shunit2

# テストスクリプトのTearDown
rm -rf stub.$$
