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

" phpの時は文字コードをeuc-jpに設定
autocmd FileType php :set fileencoding=euc-jp


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


" buffer を使いやすくする
noremap <Left> :bprev<CR>
noremap <Right> :bnext<CR>
" バッファに開かれたファイルを保存していなくてもファイルが切り替えられるようにする
:set hidden

" 無効化
noremap ZZ <Nop>
noremap ZQ <Nop>
noremap Q <Nop>

" vimplug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
endif
call plug#begin('~/.local/share/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'pangloss/vim-javascript'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
Plug 'mattn/vim-sqlfmt'
call plug#end()
" brew install fzf
" brew install repgrep
" need nodejs and npm (for LSP)

" GitGutter
" https://wonderwall.hatenablog.com/entry/2016/03/26/211710
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=0
highlight GitGutterAdd    ctermfg=2 ctermbg=0
highlight GitGutterChange ctermfg=3 ctermbg=0
" GitGutter の更新間隔を早める (4000ms(default) => 250ms)
set updatetime=250

let g:htl_css_templates = 1

" vim-airline
let g:airline_powerline_fonts = 1

" gruvbox
syntax enable
set background=dark
colorscheme gruvbox

" deno and vim-lsp
if executable("deno")
  augroup LspTypeScript
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ "name": "deno lsp",
    \ "cmd": {server_info -> ["deno", "lsp"]},
    \ "root_uri": {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), "tsconfig.json"))},
    \ "whitelist": ["typescript", "typescript.tsx"],
    \ })
  augroup END
endif

noremap sp :GFiles<CR>
noremap sP :GFiles?<CR>
noremap sb :Buffer<CR>
noremap sf :Rg<CR>
noremap bt :NERDTree<CR>


" フォーマットのオプションを変更
let g:sqlfmt_program = "sqlformat --comma_first true -r -k upper -o %s -"

" マッピング設定
nmap <buffer><leader>sf <Plug>(sqlfmt)