# shell-stub
シェルスクリプトのスタブ作成用のスクリプトです。

# 使用準備

$ git clone https://github.com/hihdrum/shell-stub.git
Cloning into 'shell-stub'...
remote: Enumerating objects: 139, done.
remote: Counting objects: 100% (139/139), done.
remote: Compressing objects: 100% (71/71), done.
remote: Total 139 (delta 58), reused 134 (delta 55), pack-reused 0
Receiving objects: 100% (139/139), 18.80 KiB | 6.27 MiB/s, done.
Resolving deltas: 100% (58/58), done.

「Download ZIP」からダウンロードして解凍しても構いません。

$ ls
shell-stub

shell-stubに移動してパスを通します。

$ cd shell-stub/
$ PATH=$(pwd):$PATH

実際にスタブを作成して使ってみます。スタブはstubディレクトリに配置することにします。

$ mkdir stub
$ cd stub/

## スタブの作成

sample.shというシェルスクリプトのスタブを作成します。

$ make.stub.sh sample.sh
$ ls
sample.sh            sample.sh.clear.callcount  sample.sh.rm.history
sample.sh.callcount  sample.sh.init             sample.sh.set.expect

スタブ配置ディレクトリにもパスを通しておきます。

$ PATH=$(pwd):$PATH

呼び出しテスト用の別ディレクトリを作成し実際に使ってみます。

$ mkdir ../calltest
$ cd ../calltest/

## 期待値の設定
1回目の呼び出し時に0を、2回目の呼び出し時に1を返す設定を行い呼び出してみます。

$ sample.sh.set.expect 1 0 ""
$ sample.sh.set.expect 2 1 ""

$ sample.sh
$ echo $?
0
$ sample.sh
$ echo $?
1

標準出力への出力も設定することができます。(標準エラー出力には対応していません。)

$ sample.sh.set.expect 1 0 "ABC"
$ sample.sh.set.expect 2 10 "$(echo DEF)"

スタブは呼び出された回数をファイルに記録し覚えているので、再度1回目として呼び出すにはクリア処理を行って呼び出します。

$ sample.sh.clear.callcount










1回目の呼び出し時に戻り値10を返し,100を出させたい場合、
スタブ名.set.expectを実行します。

$ sample.sh.set.expect 1 10 "output 100"

呼び出し例

$ sample.sh
output 100$ echo $?
10

期待値を設定していない状態でスタブを呼び出すとエラーになります。

$ sample.sh
cat: スタブ配置ディレクトリ/sample.sh.expect.return002: そのようなファイルやディレクトリはありません
戻り値を設定するファイル(スタブ配置ディレクトリ/sample.sh.expect.return002) がcatできませんでした。

## 呼び出し回数のクリア
スタブは呼び出された回数をファイルに保持しており、呼び出された際は呼び出し回数に対応した戻り値、出力ファイルを参照し期待値を返します。呼び出し回数を0にクリアしたい場合は以下を実行します。

$ sample.sh.clear.callcount

期待値設定のクリアは行わないため設定済の期待値は再度使用することができます。

$ sample.sh
output 100$ echo $?
10

## 呼び出し情報
スタブを呼び出すと呼び出された際の引数の個数(argc)と各引数の情報(argX)を保持するファイルがワーキングディレクトリに作成されます。1回目に呼ばれた場合のファイルがhistory001となります。

$ ls
sample.sh.history001.argc

$ cat sample.sh.history001.argc
0

呼び出し時に引数を渡さなかったのでargcは0となっています。

$ sample.sh.clear.callcount
$ sample.sh 1 AB "C D"
output 100$

$ ls
sample.sh.history001.arg1  sample.sh.history001.arg3
sample.sh.history001.arg2  sample.sh.history001.argc
$ cat sample.sh.history001.arg1
1
$ cat sample.sh.history001.arg2
AB
$ cat sample.sh.history001.arg3
C D

呼び出し情報は以下で削除できます。

$ sample.sh.rm.history
$ ls

# 初期化(呼び出し回数のクリア, 期待値設定のクリア)




# 使用例
