"===== 日本語化 =====
" A project which translate Vim documents into Japanese.
call plug#begin('~/.vim/plugged')
Plug 'vim-jp/vimdoc-ja'
call plug#end()
set helplang=ja,en


"===== インデント =====
" インデント幅
set shiftwidth=2
" タブ文字の表示幅
set tabstop=2
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2
" 挿入モードでタブキー押下時に半角スペースを挿入
set expandtab
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent


"===== encoding =====
set encoding=utf8
scriptencoding utf8
set fileencoding=utf-8
set termencoding=utf8
set fileencodings=utf-8,ucs-boms,euc-jp,ep932
set fileformats=unix,dos,mac
set ambiwidth=double
set nobomb
set t_Co=256


"===== クリップボード =====
" クリップボード連携
:set clipboard+=unnamed
" Mac(homebrew版)以外では検証していない。 環境による条件分岐が必要かも


"===== swapファイル =====
" swapファイルの生成先を指定
:set directory=~/.vim/tmp
" swapファイルを作成しない
" :set noswapfile


"===== キー入力 =====
"方向キーの無効化 
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
 
"入力モード時のカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" xで削除した時はヤンクしない
vnoremap x "_x
nnoremap x "_x

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" 挿入モードでバックスペース削除を有効
set backspace=indent,eol,start

"===== その他 =====
" 行番号を表示
set number
" ビープ音を消す
set belloff=all
" 検索した時にハイライト
set hlsearch
" 対応する括弧を強調表示
set showmatch
" タイトルを表示
set title
