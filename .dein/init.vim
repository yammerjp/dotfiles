"===== dein.vim ======
" dark powered vim plugin manager

" Set variables
let g:rc_dir    = expand('~/.dein')
let s:toml      = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
let s:dein_repo_dir = g:rc_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim, if it isn't exist
set nocompatible
if !isdirectory(s:dein_repo_dir)
  echo "Install dein.vim.  Wait a few minutes..."
  call system( 'git clone git://github.com/Shougo/dein.vim ' . s:dein_repo_dir )
  call system( 'touch -m ' . s:toml )
  call system( 'touch -m ' . s:lazy_toml )
endif
execute 'set runtimepath^=' . s:dein_repo_dir

" Load dein.vim settings
if dein#load_state(g:rc_dir)
  call dein#begin(g:rc_dir)

  " Load plugins from toml
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" Check plugins not installed yet.
if dein#check_install()
  call dein#install()
endif

