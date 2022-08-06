#!/bin/bash

# 本ディレクトリに shunit2 を用意して下さい。

# --------------------------------------------------------------------------
# 組み込みコマンドcd、echo を利用しているスクリプトで、cd、echoの動作を
# スタブで制御する例
# --------------------------------------------------------------------------

# 試験対象スクリプトにパスを通す。
PATH=./bin:$PATH

oneTimeSetUp() {
  mkdir stub.$$
  pushd stub.$$ > /dev/null
  ../../../make.stub.sh cd
  ../../../make.stub.sh echo
  popd > /dev/null
}

setUp() {
  #--------------------------------------------------------------------
  # スタブ配置ディレクトリにパスを通す。
  # ビルトインコマンドの影響がこの箇所でも出る場合は、試験対象シェルの
  # 呼び出し直前などに移動する。
  #--------------------------------------------------------------------
  PATH=./stub.$$:$PATH
}

tearDown() {
  if [ -e stub.$$ ]; then
    cd.rm.history
    echo.rm.history
  fi
}


test_cdError() {

  cd.init
  cd.set.expect 1 1

  # ビルトインコマンドの無効化
  enable -n cd

  # enable -n は子シェルに影響しないようなので、カレントシェルでexample01.shを実行する。
  output=$(. example01.sh)
  ret=$?

  # ビルトインコマンドの有効化
  enable cd

  assertEquals "戻り値" 1 ${ret}
  assertEquals "出力" "_" "_${output}"
  assertEquals "cd引数" "." $(cat cd.history001.arg1)
  assertTrue "echoが実行されていないこと" 0 $(test ! -r echo.history001.argc)
}

test_echoError() {

  cd.init
  echo.init

  cd.set.expect 1 0
  echo.set.expect 1 1

  enable -n cd
  enable -n echo

  output=$(. example01.sh)
  ret=$?

  enable cd
  enable echo

  assertEquals 1 ${ret}
  assertEquals "_" "_${output}"
  assertEquals "." $(cat cd.history001.arg1)
  assertEquals "ABC" $(cat echo.history001.arg1)
}

test_NoError() {

  cd.init
  echo.init

  cd.set.expect 1 0
  echo.set.expect 1 0

  enable -n cd
  enable -n echo

  output=$(. example01.sh)
  ret=$?

  enable cd
  enable echo

  assertEquals 0 ${ret}
  assertEquals "_" "_${output}"
  assertEquals "." $(cat cd.history001.arg1)
  assertEquals "ABC" $(cat echo.history001.arg1)
}

# Load shuUnit2.
. ../shunit2

# テストスクリプトのTearDown
# oneTimeTeaDownに記述すると上手く行かないので
# ここで行う。
rm -rf stub.$$

