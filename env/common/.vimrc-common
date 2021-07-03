colorscheme pablo
"========== dein.vim ==========
if filereadable(expand('~/.dein/init.vim'))
    source ~/.dein/init.vim
endif


"========== インデント ==========
" 不可視文字を可視化(タブが「>-」と表示される)
set list listchars=tab:>-
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


"========== encoding ==========
set encoding=utf8
scriptencoding utf8
set fileencoding=utf-8
set termencoding=utf8
set fileencodings=utf-8,ucs-boms,euc-jp,ep932
set fileformats=unix,dos,mac
set ambiwidth=double
set nobomb
set t_Co=256


"========== クリップボード ==========
if has("mac")
  set clipboard=unnamed
elseif has("unix")
  set clipboard=unnamedplus
  " $ vim --version | grep clipboard の結果が -clipboard であれば, インストールされた vim は Xwindow のクリップボードに対応していない.
  " vim-gtk をインストールする
endif


"========== swapファイル ==========
" swapファイルのディレクトリが存在しなければ作成
let s:swap_dir = expand('~/.vim/tmp')
if !isdirectory(s:swap_dir)
  call system( 'mkdir -p ' . s:swap_dir )
endif
" swapファイルの生成先を指定
:set directory=~/.vim/tmp


"========== キー入力 ==========
" xで削除した時はヤンクしない
vnoremap x "_x
nnoremap x "_x

" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>

" 挿入モードでバックスペース削除を有効
set backspace=indent,eol,start


"========== その他 ==========
" 行番号を表示
set number
" 行番号を非表示
" set nonumber

" ビープ音を消す
set belloff=all
" 検索した時にハイライト
set hlsearch
" 対応する括弧を強調表示
set showmatch
" タイトルを表示
set title

syntax on

hi SpecialKey ctermbg=NONE ctermfg=237 guibg=NONE guifg=NONE

set splitright
:command Term :vert terminal

highlight LineNr ctermfg=239

"========== vim-git-gutter ==========
" GitGutter の色変更 ~/.dein/dein.toml の hook_add に書いても適用されないので .vimrc に記載
" https://wonderwall.hatenablog.com/entry/2016/03/26/211710
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=0
highlight GitGutterAdd    ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
" GitGutter の更新間隔を早める (4000ms(default) => 250ms)
set updatetime=250
