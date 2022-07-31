#!/bin/bash

# 本ディレクトリに shunit2 を用意して下さい。

oneTimeSetUp() {
  rm -rf stub
  mkdir stub.$$
  pushd stub.$$ > /dev/null
  ../../make.stub.sh sample.sh
  popd > /dev/null
}

test_Make_shell() {
  assertTrue "[ -x stub.$$/sample.sh ]"
}

test_Make_clearCallcount() {
  assertTrue "[ -x stub.$$/sample.sh.clear.callcount ]"
}

test_Make_setExpect() {
  assertTrue "[ -x stub.$$/sample.sh.set.expect ]"
}

test_Make_init() {
  assertTrue "[ -x stub.$$/sample.sh.init ]"
}

test_Make_rmHistory() {
  assertTrue "[ -x stub.$$/sample.sh.rm.history ]"
}

test_Make_callcount() {
  assertTrue "[ -r stub.$$/sample.sh.callcount ]"
  assertEquals 0 $(cat stub.$$/sample.sh.callcount)
}

# Load shuUnit2.
. ./shunit2

# テストスクリプトのTearDown
rm -rf stub.$$
