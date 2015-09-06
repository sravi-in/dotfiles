set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'sravi-in/ctags.vim'
Plugin 'sravi-in/cscope_macros.vim'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let g:ctags_path= "/usr/bin/ctags"
let g:ctags_statusline=1
let g:ctags_title=0
let generate_tags=1

let c_space_errors=1

nmap mw <C-w>

"highlight WhitespaceEOL ctermbg=red guibg=red
"match WhitespaceEOL /\s\+$/

set t_Co=16
set bg=dark
colorscheme solarized
syntax on

set autoindent
set expandtab
set fileformats=unix,dos,mac
set shiftwidth=4
set showmatch
set softtabstop=4
set tabstop=8
set ttyfast
set visualbell
set wrap

