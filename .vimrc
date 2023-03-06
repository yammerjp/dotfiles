set number " 行番号を表示
set belloff=all " ビープ音を消す
syntax on
hi Visual ctermbg=239 " 文字選択時のハイライト色を黒に近づける
" xで削除した時はヤンクしない
vnoremap x "_x 
nnoremap x "_x
" Escの2回押しでハイライト消去
nnoremap <Esc><Esc> :nohlsearch<CR><ESC>
set backspace=indent,eol,start " 挿入モードでバックスペース削除を有効
set hlsearch " 検索した時にハイライト

set list listchars=tab:>- " 不可視文字を可視化(タブが「>-」と表示される)
set expandtab " 挿入モードでタブキー押下時に半角スペースを挿入
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する

noremap <Left> :bprev<CR>
noremap <Right> :bnext<CR>
" バッファに開かれたファイルを保存していなくてもファイルが切り替えられるようにする
:set hidden

if has("mac")
  set clipboard=unnamed
elseif has("unix")
  set clipboard=unnamedplus
  " $ vim --version | grep clipboard の結果が -clipboard であれば, インストールされた vim は Xwindow のクリップボードに対応していない. vim-gtk をインストールする
endif

set softtabstop=2 " タブキー押下時に挿入される文字幅を指定
set shiftwidth=2 " インデント幅
set tabstop=2 " タブ文字の表示幅
set nobomb
