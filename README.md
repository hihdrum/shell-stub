# shell-stub
シェルスクリプトのスタブ作成用のスクリプトです。

シェルスクリプトの単体試験時のスタブ作成の手間を減らせないかと作成しました。

期待値設定 : 指定回数呼び出し時の戻り値と出力を設定します。


# 使用準備から使用例まで

$ git clone https://github.com/hihdrum/shell-stub.git

「Download ZIP」からダウンロードして解凍しても構いません。

$ ls
shell-stub

## パスの設定

shell-stubに移動してmake.stub.shがあるディレクトリにパスを通します。

$ cd shell-stub/
$ PATH=$(pwd):$PATH

## スタブの作成

実際にスタブを作成して使ってみます。スタブはstubディレクトリに配置することにします。

$ mkdir stub
$ cd stub/

sample.shというシェルスクリプトのスタブを作成します。

$ make.stub.sh sample.sh

sample.sh他スタブで使用するファイルが作成されます。
スタブを作成したディレクトリにもパスを通しておきます。

$ PATH=$(pwd):$PATH

## テスト用ディレクトリの作成

呼び出しテスト用の別ディレクトリを作成し実際に使ってみます。

$ mkdir ../calltest
$ cd ../calltest/

## 期待値の設定と呼び出し
sample.shの1回目の呼び出し時に0を、2回目の呼び出し時に1を返す設定を行い呼び出してみます。

### 戻り値
$ sample.sh.set.expect 1 0
$ sample.sh.set.expect 2 1

$ sample.sh; echo $?
0
$ sample.sh; echo $?
1

呼び出し時の引数は以下の様になっています。

$ sample.sh.set.expect
Usage : sample.sh.set.expect 回数 戻り値 [標準出力]


### 標準出力
標準出力への出力値も設定してみます。
上記からの流れで2回呼ばれたことになっているので、実行前にスタブで保持している呼び出し回数の情報をクリアします。

$ sample.sh.clear.callcount

$ sample.sh.set.expect 1 0 "ABC"
$ sample.sh
ABC$

標準出力への設定は以下も使うことができます。より複雑な出力を設定する場合はこちらが良いと思います。

$ echo -e "A\nBC" > $(sample.sh.get.expect.stdout.path 1)
$ sample.sh
A
BC
$ echo $?
0

呼び出し時の引数は以下の様になっています。
$ sample.sh.get.expect.stdout.path
Usage : sample.sh.get.expect.stdout.path 回数

$ sample.sh.get.expect.stdout.path 1
スタブを作成したディレクトリ/sample.sh.expect001.stdout

sample.sh.expect001.stdoutが1回目に呼び出された際に標準出力に出力する情報を保持するファイルになっています。このファイルを直接編集しても構いません。

### 未設定時

期待値を設定している回数を超えて呼び出すと以下のようなエラーとなります。

$ sample.sh
cat: スタブを作成したディレクトリ/sample.sh.expect003.return: そのようなファイルやディレクトリはありません

## 呼び出し回数のクリア
スタブは呼び出された回数をファイルに保持しており、呼び出された際は呼び出し回数に対応した戻り値、出力ファイルを参照し期待値を返します。呼び出し回数を0にクリアしたい場合は以下を実行します。

$ sample.sh.clear.callcount

期待値設定のクリアは行わないため設定済の期待値は再度使用することができます。

$ sample.sh
A
BC
$ echo $?
0


## 呼び出し引数履歴
スタブを呼び出すと呼び出された際の引数の個数(argc)と各引数の情報(argX)を保持するファイルがワーキングディレクトリに作成されます。1回目に呼ばれた場合のファイルがhistory001となります。

$ cat sample.sh.history001.argc
0

呼び出し時に引数を渡していない場合、argcは0となります。
引数を渡して呼び出してみます。

$ sample.sh.clear.callcount
$ sample.sh 1 "A B" C
A
BC
$ cat sample.sh.history001.argc
3
$ cat sample.sh.history001.arg1
1
$ cat sample.sh.history001.arg2
A B
$ cat sample.sh.history001.arg3
C

## 呼び出し引数履歴のクリア
呼び出し引数履歴のファイルはrmで直接削除しても構いませんが、以下でも行うことができます。

$ sample.sh.rm.history

# 初期化(呼び出し回数のクリア, 期待値設定のクリア)
呼び出し回数のクリアと期待値設定のクリアを同時に行いたい場合は、以下のコマンドで行うことができます。

$ sample.sh.init


# 使用例
