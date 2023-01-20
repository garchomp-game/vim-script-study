# vim script学習メモ

1.0e6や、1.0e-3等、指数を指定する場合は、
小数点(.)等を省略することはできない。

日本語の文字の場合、配列型として引数を指定すると
ユニコードの確認が可能になる

文字列、シングルクォートとダブルクォートの違い。
例えば、ダブルクォートの場合、特殊文字を解釈する事ができる
※\n等の改行文字等

リスト型は混在可能

文字列内においての\000と\x00は、終端文字として扱われる（つまりEOF）
それ移行は読まれなくなるので、途中で止めたい場合はこれらの文字コードを
使うと良い。

配列の追加は

```vim
let list = [
\ 'foo',
\ 'bar',
\ 'baz',
\ 'qux'
\ ]
```

と追加してもいいが、この書き方はcpoptionsにCフラグが含まれているときのみ
有効である

処理も結構重くなりがちなので、addメソッドを使うことが推奨されている。

```vim
let list = []
call add(list, 'foo')
call add(list, 'bar')
call add(list, 'baz')
call add(list, 'qux')
```

TIPS: 関数はcallを使って呼び出す
なお、vim9scriptの限り、callはオプションであり、使わなくてもよい。

定義済みのリストの数を取得するには、lenメソッドを使う
配列の内容を取得する場合、通常の配列と同じである。
getメソッドを使うと、エラー発生した場合は第2引数の内容を実行する

```vim
echo len(list)
echo list[3] "error
echo get(list, 3, 'not found') "ok
```

list関連のメソッドは以下のようなものがある

|操作    |説明                    |
|--------|------------------------|
|len()   |要素の個数を取得する    |
|[]      |要素を参照する(取得する)|
|add()   |要素を追加する          |
|remove()|要素を削除する          |
|join()  |要素を連結し文字列にする|

## 辞書形について

辞書型の宣言は以下の通り

```vim
let en2ja = {'one': 'いち', 'two': 'に', 'three': 'さん'}
echo en2ja['one']
```

キーには数字を指定することも可能だが、内部的には
文字列に変換される。
lenで辞書型の要素数の取得が可能

|操作     |説明                            |
|---------|--------------------------------|
|len()    |要素の個数を取得する            |
|get()    |要素の値を取得する              |
|[]       |要素の値を参照する              |
|has_key()|キーが存在するか確認する        |
|remove() |要素を削除する                  |
|keys()   |キーの一覧をリストとして取得する|
|values() |値の一覧をリストとして取得する  |

## vimオブジェクト

vimには暗黙的な方が存在する

- バッファ
- ウィンドウ

vim scriptから見ると厳密には型とは言い難いが、操作対象となるという
意味では方と捉えてしまうのもあり。

### バッファ操作

バッファの行に追加する場合、append関数で実現できる

```vim
append(0, 'foo')
```

文字連結やstringメソッドを使い、このような事もできる。

```vim
call append(0, 'echo' . string(2980 * 1.08))
```

## 式とその評価

vimの関数は、expression(式)であるが、vimはコマンドから開始しなければならない。
そのため、vimでは式から書いたらエラーとなるのであった。
:callはできても、:append()はコマンドではないため、エラーとなる。

:echoや:let等がある場合は、先にechoコマンドやletコマンドから開始しているため、
エラーにならない

```vim
" 以下の書き方は正しい
:echo len('foobar')
:let l = len('foobar')
:echo l
" 以下は実行できるが、戻り値は無視される。
:call len('foobar')
```

### 部分文字列の操作

文字列は、配列として操作することができる。
リスト操作のような形で操作が可能となる。

```vim
let s = "ABCDE"
echo s[0]
echo s[1]
echo s[1:3] " BCD
```

複数指定する場合は、[start:end]であることに注意。
end-1ではない。(javaのsubtstringとごっちゃにならないように注意)

つまり、以下の２つは同じ意味となる

```vim
echo s[2]
echo s[2:2]
```

開始位置や終了位置のどちらかを省略することもできる

```vim
echo s[:2]
echo s[2:]
```

マイナスにすると、末尾から指定したことになる

```vim
echo s[-2:] " DE
echo s[:-2] " ABCD
echo s[-4:-2] " BCD
```

### matchstr()

matchstrは、正規表現を指定してマッチした部分文字列を返す。
[x:y]での取り出しは、シンプルすぎて実務に向かないことがある。
その場合、matchstrを使うと、正規表現文字を使ったパースができる。

```vim
let s = 'year 2023'
echo matchstr(s, '\d\+') "2013
```

日本語の文字を取得するには、次のような正規表現を行う

```vim
let t = 'あいうえお'
echo matchstr(t, '^.\{2}\zs.')
```

末尾の.を.\{number}に変えることで、開始地点と終了地点の指定が可能になる

```vim
echo matchstr(t, '^.\{1}\zs.\{3}')
```

また、joinを使った方法もある。

```vim
echo join(split(t, '\zs')[1:3], '')
```

このテクニックは、リストを一度生成してから行っているため、
実行速度に影響しやすい。使用する場合は慎重に検討しておくこと。

### 文字列の比較

文字列の比較は、==や=!で比較することができる。
大文字と小文字の区別は、予めオプション(set ignorecase)がセットしてあるか否かで
結果が変わってくる。

※ignorecaseはboolである

### 文字の大小比較

大小比較は、<や>を使って行われる

```vim
echo 'aa' < 'ab' "true
echo 'aa' > 'ab' "false
```

ちなみに、アルファベットのaにはいくつかの種類がある。
これらのロケールの一致の確認方法は無い。

ちなみに、==以外に==#や==?がある。
\#は、大文字小文字考慮。?が無視する式。
ignorecase抜きでチェックする場合はこの辺も重要になってくる

### 正規表現を用いた比較/マッチ

正規表現を用いる演算子は=~である。

```vim
let s1 = 'alphabet'
let s2 = 'beautigful'

echo s1 =~ 'a.*b'
" 1

echo s2 =~ 'a.*b'
" 0
```

!~は逆にマッチしない場合のみ1が帰る。

|比較内容              |区別する|区別しない|'ignorecase'に依存|
|----------------------|--------|----------|------------------|
|同じ                  |==#     |==?       |==                |
|異なる                |!=#     |!=?       |!=                |
|小さい                |<#      |<?        |<                 |
|同じか小さい          |<=#     |<=/       |<=                |
|大きい                |>#      |>?        |>                 |
|同じか大きい          |>=#     |>=?       |>=                |
|正規表現にマッチする  |=~#     |=~?       |=~                |
|正規表現にマッチしない|!~#     |!~?       |!~                |

### 文字列型と数字型の型変換

vimスクリプトでは、文字列型と、数字型を区別する必要はあまりない。
必要になったら自動で型変換してくれる。

ただし、リスト型等、文字列と数値以外は自動で型変換は行われない。

コメントは"で始まる文字列である。

## vimスクリプト詳説

### 変数とそのスコープについて

スコープの種類について。

(無し) 関数の中では関数ローカル
旧来のスクリプトでは: グローバル
Vim9 script では: スクリプトについてローカル
buffer-variable    b: 現在のバッファにローカル
window-variable    w: 現在のウィンドウにローカル
tabpage-variable   t: 現在のタブページにローカル
global-variable    g: グローバル
local-variable     l: 関数にローカル(旧来の関数のみ)
script-variable    s: :sourceされたVim scriptにローカル
function-argument  a: 関数の引数(旧来の関数のみ)
vim-variable       v: グローバル、Vimがあらかじめ定義

ウィンドウスコープの場合、カレントウィンドウと異なるウィンドウの
変数にアクセスするには、getwinvar()及びsetwinvar()を使う。

### オプション

厳密には、スコープや変数とは言い難いが、変数の名前を
&出始めるとvimのオプションにアクセスが可能となる

```vim
:echo &ignorecase
```

なお、変数には省略形が使えるものもある。
例えば、ignorecaseの場合は、icと略すこともできる。

また、中にはerrorformatのように、グローバル変数とバッファ、ウィンドウ等の
ローカルなオプションも同時に存在する。

これらを明示的に分ける場合は、&g, &l接頭辞を使う。

```vim
set errorformat

echo &g:errorformat
echo &l:errorformat
echo &errorformat " &だけで始めた場合はローカルが優先される
```

### vim変数

読み取り専用のvim変数を利用できる場合がある。

```vim
let s = range(10)
echo map(s, '10 - v:val')
```

vim変数には以下のようなものがある。

|vim変数    |説明                                             |
|-----------|-------------------------------------------------|
|v:count    |map時に繰り返し回数が指定された場合にその値が入る|
|v:exception|例外が補足されたときにその内容(文字列)が入る     |
|v:key      |filter()関数等のイテレーションで辞書のキーが入る |
|v:val      |filter()関数等でイテレーションで要素の値が入る   |

### 変数のスコープ一覧

|変数の種類    |プレフィックス|説明                       |
|--------------|--------------|---------------------------|
|バッファ変数  |b:            |カレントバッファに局所化   |
|ウィンドウ変数|w:            |カレントウィンドウに局所化 |
|タブ変数      |t:            |カレントタブに局所化       |
|グローバル変数|g:            |グローバル/全体で共有される|
|ローカル変数  |l:            |関数に局所化               |
|スクリプト変数|s:            |スクリプトファイルに局所化 |
|オプション    |&             |vimのオプション            |
|vim変数       |v:            |vimによって定義される      |
|環境変数      |$             |OSの環境変数にアクセス     |
|関数の引数    |a:            |引数宣言時に使う           |

引数についての例

```vim
function! myFunc(arg1, arg2)
echo a:arg1
echo a:arg2
endfunction
```

### 変数操作コマンド/関数の紹介

- let: 変数の定義、設定をするコマンド
値を更新する際にも必要になる。

- unlet: 変数を削除するコマンド

### letのバリエーションについて

```vim
let score = 0
let score += 100
let score -= 100
let msg = 'Hello'
let msg .= 'World'
" リストから値のアンパックをするletの例
let [v1, v2, v3] = range(10)
echo v1 " 1
echo v2 " 2
echo v3 " [3,4,5,6,7,8,9,10]

let[x, y] = ['foo', 'bar']
echo x y
" foo bar
let [x, y] = [y, x]
echo x y
"bar foo
```

### 関数の利用と定義

### 関数定義のしかた

以下は再帰関数の例

```vim
function! s:Factorial(num)
  return a:num > 1 ? a:num * s:Factorial(a:num - 1) : 1
endfunction
```

function!ではなく、functionを使う事もできるが、functionを使った場合、
もし定義済みの関数が会った場合はエラーになるので、
基本的にはfunction!を使ったほうが安全である。

なお、function!にもスコープの指定は可能
関数の引数は最大２０個まで受け取ることができる。

可変長引数は、a:000で可変長引数の配列の参照ができる。
a:0で、可変長引数の数を取得することができる。(つまりlen(a:000)と同じ)

```vim
function! Average(...)
  let total = 0.0
  for item in a:000
    let total += item
  endfor
  return total / a:0
endfunction
```

### 関数のオプション

関数の定義には、range,abort,dictの３つのオプションを指定することが可能。

- rangeオプション
callコマンドで関数を呼び出すときに範囲指定した場合に、
その関数をどのように呼び出すかを決定する。
callコマンドは通常のexコマンドの一つのため、範囲指定を受け付ける。
rangeオプションが指定されていない関数を範囲指定して呼び出すと、
範囲の最初から最後まで1行ずつカーソルを移動しつつ、複数回その関数が呼び出される。

```vim
function! WithoutRange() range
  echo line('.')
endfunction
```

:7,11call WithRange()とすることで、呼び出すことができる。

- abortオプション
関数内の処理でエラーが発生した場合、実行を中断する

```vim
function! WithAbort() abort
  let v = undefined_variable
  echo "OMG (not aborted)"
endfunction
```

- dictオプション
辞書関数を定義するのに使う。

### スクリプトローカル関数

スクリプトローカル関数は、スクリプトファイル無いからのみ
呼び出せる関数。

```vim
function! s:world()
 return "World"
endfunction

function! Hello()
  return 'hello ' . s:world()
endfunction
```

いわゆるプライベートメソッドである。

### autoload関数

autoloadは、起動直後はすぐには読み込まれない関数。
これにより、起動速度の向上が期待できる。

autoload関数は、一つ以上関数に#がついているものが対象になる。

呼び出す場合は、
:call filename#funcname()
といった形で呼び出す。関数の定義は以下の通りである。

```vim
function filename#funcname()
  echo 'Done!'
endfunction
```

### 関数の呼び出し

呼び出し方は以下の三種類

- 評価(expr)
- callコマンド
- call関数

```vim
function! Fibo(num)
  if a:num == 0
    return 0
  elseif a:num == 1
    return 1
  else
    return Fibo(a:num - 1) + Fibo(a:num - 2)
  endif
endfunction

for i in range(1, 10)
  " echo Fibo(i)
  echo call('Fibo', [i])
endfor
```

再帰呼び出しには、階層に制限がある。
デフォルトの上限は、maxfuncdepth = 100となっている

### fizzbuzzのサンプルとループ文

```vim
function! FizzBuzz(num)
  if a:num % 3 == 0 && a:num % 5 == 0
    return 'FizzBuzz'
  elseif a:num % 3 == 0
    return 'Fizz'
  elseif a:num % 5 == 0
    return 'Buzz'
  else
    return a:num
  endif
endfunction

for i in range(1, 100)
  echo FizzBuzz(i)
endfor
```

基本的に、ループ分はwhileを使うのば主流。
なぜなら、for文は、for~inの形で使うためである。

ちなみに、vimにはcontinue break文が普通に存在する。

### 例外について

例外は以下のような形で投げられる

```vim
function! Assert1to10(num)
  if a:num < 1 || a:num > 10
    throw 'Out of range: ' . a:num
  endif
endfunction

function! Guess()
  try
    call Assert1to10(input('Guess a number: '))
    echo "\nYou are right!"
  catch /^Out of range: .*/
    echo "\nSomething bad..."
  finally
    echo 'Thank you for playing'
  endtry
endfunction

call Guess()
```

### オブジェクト指向っぽい書き方について

たとえば、以下のような書き方がある

```vim
function! NewVec2D(x, y)
  return {'x': a:x, 'y': a:y, 'len':function("Length")}
endfunction

function! Length() dict
  return sqrt(self.x * self.x + self.y * self.y)
endfunction

let numList = NewVec2D(3, 4)
echo numList
echo numList.len()

```

これをさらにオブジェクト指向っぽく改良したのが以下。

```vim
" メンバ定義部分
let g:vec2d = {
      \'x':0, 
      \'y':0
      \}

" コンストラクタ
function! NewVec2D(x, y)
  let self = copy(g:vec2d)
  let self.x = a:x
  let self.y = a:y
  return self
endfunction

" メソッド定義
function! g:vec2d.len() dict
  return sqrt(self.x * self.x + self.y * self.y)
endfunction

```

## vimの機能の使い方

### Exコマンド

大前提として、vimスクリプトはExコマンドの拡張である。
すべてのExコマンドは有効なvimスクリプトである。
