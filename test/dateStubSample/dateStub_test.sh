#!/bin/bash
# --------------------------------------------------------------------------
# shunit2のQuickstartで紹介されているtestPartyLikeItIs1999テストをdataの
# スタブを使用して失敗させずに通してみます。
# --------------------------------------------------------------------------
oneTimeSetUp() {
  mkdir stub
  pushd stub > /dev/null
  ../../../make.stub.sh date
  popd > /dev/null
}

tearDown() {
  if [ -e stub ]; then
    ./stub/date.rm.history
  fi
}

#----------------------------------------
# shunit2 Quickstartのサンプル失敗する。
#----------------------------------------
testPartyLikeItIs1999() {
  year=$(date '+%Y')
  assertEquals "It's not 1999 :-(" '1999' "${year}"
}

#----------------------------------------
# stubのdateを使用して1999を出力するようにする。
#----------------------------------------
testPartyLikeItIs1999_UseStub() {
  PATH=./stub:$PATH

  date.init
  date.set.expect 1 0 "1999"

  year=$(date '+%Y')
  assertEquals "It's not 1999 :-(" '1999' "${year}"
}

# Load shuUnit2.
. ../shunit2

rm -rf stub

