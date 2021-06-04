""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gestion des plugins avec Plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load vim-plug if not present
if empty(glob("~/.vim/autoload/plug.vim"))
 execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
" Adds plugins from remote repos

Plug 'w0rp/ale'
Plug 'tomtom/tcomment_vim' " comments (gcc)
Plug 'godlygeek/tabular'
Plug 'tarikgraba/vim-systemverilog'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on    " required

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

" Remplace tabs with 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a

set encoding=utf-8

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
