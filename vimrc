set tabstop=8
set shiftwidth=2
set expandtab

map ~mai i#include<stdio.h><CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>}<CR><Esc>kka<Tab>
map ~cmai i#include<iostream><CR><CR>using namespace std;<CR><CR>int main(int argc,char *argv[],char *envp[])<CR>{<CR><CR>return 0;<CR>}<CR><Esc>kka<Tab>
map ~for ofor(int i=0; i; i++)<CR>{<CR>}<CR><Esc>kkkf;f;i

set incsearch
set hlsearch
set expandtab
set showcmd
set ai
set cindent

if !has("gui_running")
    set t_Co=8
    set t_Sf=^[[3%p1%dm
    set t_Sb=^[[4%p1%dm
endif

syntax enable

highlight search term=standout ctermfg=0 ctermbg=3 guifg=black guibg=yellow
highlight comment term=underline ctermfg=6 guifg=DarkCyan

nmap gb /\.\.\/<CR>
"nmap m  <C-d>
"nmap q  <C-u>
"nmap gf <C-f>
"nmap gb <C-b>
nmap mw <C-w>
set bg=light
let c_space_errors=1
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

map + <Esc>:cn<CR>
map - <Esc>:cp<CR>
map <F2> :WMToggle<CR>      " map F2 to make WMToggle

"for the ctags.vim plugin.
let g:ctags_path= "/usr/bin/ctags"
let g:ctags_statusline=1
let g:ctags_title=0
let generate_tags=1

"set nofsync
