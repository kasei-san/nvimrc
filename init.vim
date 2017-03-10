"autocmd 初期化
augroup MyAutoCmd
  autocmd!
augroup END

" 256色対応
set t_Co=256
colorscheme elflord

"---------------------------------------------------------------------
" basic {{{
"---------------------------------------------------------------------
" 行番号を表示
set number
" 相対行番号を有効にする
" set relativenumber

" ルーラーを表示
set ruler

" タイトルを表示
set title

" 常にステータス行を表示
set laststatus=2

" コマンドラインの高さ
set cmdheight=2

" コマンドをステータス行に表示
set showcmd

" 履歴
set history=1000

"tabの代わりに空白を使う
set expandtab

"tabが対応する空白の数
set tabstop=2

"インデントの幅
set shiftwidth=2

"新しい行を作るときに高度な自動インデントを行う
set cindent

"タブ文字、行末など不可視文字を表示する
set list

"listで表示される文字のフォーマットを指定する
set listchars=tab:>\ ,extends:<,trail:_

"バックスペースでindentを無視 & 改行を越えてバックスペースを許可
set backspace=indent,eol

"入力補完時に、辞書ファイルも読み込む
set complete=.,w,b,u,t,i,k

"共有のクリップボードを使用する
set clipboard=unnamed

"カーソルを行頭/末尾で止めない
set whichwrap=b,s,h,l,<,>,[,]

"変更中のファイルでも、保存しないで他のファイルを表示
set hidden

"swapファイルをまとめて置く場所(DropBox対策)
set swapfile
set directory=~/.vimswap

"backupファイルをまとめて置く場所(DropBox対策)
set backup
set backupdir=~/.vimbackup

"コマンド補完強化
set wildmenu

"補完をzsh風に
set wildmode=longest,list

"矩形選択で自由に移動
set virtualedit=block

"折返しない
set nowrap

" esc押した時に音を出さない
set visualbell

" モードラインを有効にする
set modeline

" コマンドラインウィンドウの幅
set cmdwinheight=20

" 2バイト文字有効
set ambiwidth=double

" 括弧のハイライトを消す(括弧が複雑だと重くなる)
let loaded_matchparen = 1

" Python3 support
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

"}}}

"---------------------------------------------------------------------
" 検索関係 {{{
"---------------------------------------------------------------------
"インクリメンタルサーチを行う
set incsearch

"検索時に大文字を含んでいたら大/小を区別
set ignorecase smartcase

"検索結果をハイライト
set hlsearch

"ハイライト消去
nmap <c-j><c-j> :nohlsearch<Return><ESC>

"検索時に結果が中央に来るようにする
nnoremap n nzz
nnoremap N Nzz
"* は、単語ではなく、文字列として検索
nnoremap * g*zz
nnoremap # #zz

"ビジュアルモードで選択されている文字列を検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

"検索時に very magic とする
" set verymagic ってないのね...
nnoremap /  /\v

" s*でカーソル下のキーワードを置換
nnoremap <expr> s* ':%s/\<' . expand('<cword>') . '\>/'
vnoremap <expr> s* ':s/\<' . expand('<cword>') . '\>/'

"}}}

"---------------------------------------------------------------------
" keymap {{{
"---------------------------------------------------------------------
"tabキーでバッファ移動
nnoremap <tab> :bn<Return>
nnoremap <s-tab> :bp<Return>

" 表示行単位で移動(wrapの改行を無視)
noremap j gjzz
noremap k gkzz
vnoremap j gjzz
vnoremap k gk

" Shift-u でredo
noremap <s-u> <c-r>
" mark
nnoremap ,m :<C-u>marks<Return>
" registers
nnoremap ,r :<C-u>registers<Return>

" 行結合時に、空白を挟まない
nnoremap J gJ

" コマンドライン移動
" s-left, c-left がうまく動作しなかったので
cnoremap <tab><Left> <S-Left>
cnoremap <tab><Right> <S-Right>

" ウィンドウ移動
nnoremap <C-w><Right> <C-w>l
nnoremap <C-w><Left> <C-w>h
nnoremap <C-w><up> <C-w>k
nnoremap <C-w><Down> <C-w>j

" gvimでバックスラッシュが打てない件
inoremap ¥ \

"inoremap Y y$

" インクリメントを単純に
nnoremap + <C-a>
nnoremap - <C-x>

" terminalモード終了
tnoremap <silent> <ESC> <C-\><C-n>

"}}}

"---------------------------------------------------------------------
" EXコマンド {{{
"---------------------------------------------------------------------
" 文字コード変換
command! -bang -nargs=? Utf8
\ edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Sjis
\ edit<bang> ++enc=sjis <args>
command! -bang -nargs=? Euc
\ edit<bang> ++enc=euc-jp <args>

command! CopyRelativePath
\ let @*=join(remove( split( expand( '%:p' ), "/" ), len( split( getcwd(), "/" ) ), -1 ), "/") | echo "copied: ". @*

command! CopyFullPath
\ let @*=expand( '%:p' ) | echo "copied: ". @*

" grep に cw(Quickfixを表示)を追加
au QuickfixCmdPost vimgrep cw

" ref : http://vim-users.jp/2009/05/hack17/
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

command! -nargs=* DashRuby !open dash://ruby:'<args>'

command! -nargs=1 Refe Ref refe <args>

"}}}

"---------------------------------------------------------------------
" ファイル毎の設定 {{{
"---------------------------------------------------------------------
augroup diff
  autocmd MyAutoCmd Filetype diff setlocal encoding=utf-8
augroup END

augroup erb
  autocmd MyAutoCmd BufNewFile,BufRead *.erb setfiletype=eruby
augroup END

" ファイルタイプ毎の折りたたみ設定
autocmd MyAutoCmd Filetype vim setlocal foldmethod=marker
"}}}

"source ~/.vim/private

" tmpディレクトリでは、バックアップファイルを作らない
" via : Mac OS X で cron を使う(EDITOR=vim) - yuyarinの日記 http://d.hatena.ne.jp/yuyarin/20100225/1267084794
set backupskip=/tmp/*,/private/tmp/*

"---------------------------------------------------------------------
" 何故かhighlightが末尾にないと効かない {{{
"---------------------------------------------------------------------
"全角スペースを強調
highlight! zenkakuda ctermbg=grey ctermfg=grey guibg=black
match zenkakuda /　/
"}}}

"バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin で発動します）
augroup BinaryXXD
        autocmd!
        autocmd BufReadPre  *.bin let &binary =1
        autocmd BufReadPost * if &binary | silent %!xxd -g 1
        autocmd BufReadPost * set ft=xxd | endif
        autocmd BufWritePre * if &binary | %!xxd -r
        autocmd BufWritePre * endif
        autocmd BufWritePost * if &binary | silent %!xxd -g 1
        autocmd BufWritePost * set nomod | endif
augroup END

"---------------------------------------------------------------------
" {{{ dein.vim
"---------------------------------------------------------------------
" see: http://qiita.com/ryo2851/items/4e3c287d5a0005780034
" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " dein
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" }}}

command! -bang -nargs=? D
\ Denite<bang>-auto_preview -mode=normal <args>

" シンタックスの設定を最後にしないと正しく読まれない問題
syntax on
filetype on
filetype indent on
filetype plugin on
