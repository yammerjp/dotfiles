" A project which translate Vim documents into Japanese.
call plug#begin('~/.vim/plugged')
Plug 'vim-jp/vimdoc-ja'
call plug#end()
set helplang=ja,en

" 行番号を表示
set number

" インデント幅
set shiftwidth=2
" 挿入モードでタブキー押下時に半角スペースを挿入
set expandtab
" タブキー押下時に挿入される文字幅を指定
set softtabstop=2


