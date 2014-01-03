cmap bke<CR> :call DoBKEdit(expand("%"))<CR>
cmap bka<CR> :call DoBKAnnotate(expand("%"))<CR>
cmap bks<CR> :call ShowBKSfiles()<CR>
cmap bkd<CR> :call ShowBKDiff(expand("%"))<CR>
cmap bkfd<CR> :call ShowBKFileDiff(expand("<cfile>"))<CR>
cmap bkc<CR> :call ShowBKChange()<CR>
cmap bkrs<CR> :call ShowBKRset(expand("<cWORD>"))<CR>
cmap bkrfd<CR> :call ShowBKRsetFileDiff(expand("<cWORD>"))<CR>

function! DoBKEdit(filename)
  setlocal autoread
  silent execute "!bk edit " . a:filename
  redraw!
endfunction

function! DoBKAnnotate(filename)
  if bufexists("annotate")
        execute "bd! annotate"
  endif
  let s:lnum = line(".")
  echo "Current line " s:lnum
  execute "new annotate"
  let s:cmdName = "bk annotate -Adur " . a:filename
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer annotate"
  let s:cmdName = "normal " . s:lnum . "G"
  execute s:cmdName
endfunction


function! ShowBKRset(revno)
  if bufexists("rset")
        execute "bd! rset"
  endif
  execute "new rset"
  if stridx(a:revno,"ChangeSet@") >= 0
          let s:tmp = substitute(a:revno,"ChangeSet@","","")
          let s:revno = substitute(s:tmp,",","","")
  endif
  let s:cmdName = "bk rset -a -r" . s:revno
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer rset"
  execute "normal 1G"
endfunction

function! ShowBKChange()
  if bufexists("changes")
          execute "bd! changes"
  endif
  execute "new changes"
  let s:cmdName = "bk changes " 
  echohl Keyword
  let s:cmdOpt = input("Enter \"bk changes \" options : ","-n -u" . $USER . " -c-3M")
  echohl None
  let s:cmdName .= s:cmdOpt
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer changes"
  execute "normal 1G"
endfunction

function! ShowBKSfiles()
  if bufexists("sfiles")
          execute "bd! sfiles"
  endif
  execute "new sfiles"
  let s:cmdName = "bk sfiles -cg" 
  silent execute "0r !" . s:cmdName
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  "execute "normal buffer sfiles"
  execute "normal 1G"
endfunction

function! ShowBKDiff(filename)
  let s:fileType = &ft
  let s:ftail = expand("%:t")
  let s:ftail = "__" . s:ftail
  if bufexists(s:ftail)
          execute "bd! " . s:ftail
  endif
  execute "vnew " . s:ftail
  execute "wincmd x"
  execute "wincmd l"
  let s:cmdName = "bk get -p " . a:filename
  silent execute "0r !" . s:cmdName
  execute "set filetype=" . s:fileType
  execute "normal G-1"
  execute "normal dG"
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  execute "diffthis"
  execute "wincmd h"
  execute "diffthis"
  execute "normal 1G"
endfunction

function! ShowBKFileDiff(filename)
  execute "tabnew " . a:filename
  silent execute "call ShowBKDiff(expand(\"%\"))"
endfunction

function! ShowBKRsetFileDiff(fileline)
  let filelst = split(a:fileline,'|')
  let filedir = split(filelst[0],'/')
  let verlst = split(filelst[1],'\.\.')
  let tailidx = len(filedir) - 1
  let s:cmdName = "__" . filedir[tailidx] 
  let s:cmdName .= "@"
  let s:cmdName .= verlst[0]
  if bufexists(s:cmdName)
    execute "bd! " . s:cmdName
  endif
  silent execute "tabnew " . s:cmdName 
	silent execute "0r !bk get -p -r" . verlst[0] . " " . filelst[0]
	execute "set filetype=c"
  execute "normal G-1"
  execute "normal dG"
  set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  let s:cmdName = "__" . filedir[tailidx] 
  let s:cmdName .= "@"
  let s:cmdName .= verlst[1]
  if bufexists(s:cmdName)
    execute "bd! " . s:cmdName
  endif
	silent execute "vnew " . s:cmdName 
	silent execute "0r !bk get -p -r" . verlst[1] . " " . filelst[0]
	execute "set filetype=c"
  execute "normal G-1"
  execute "normal dG"
	set nomodified
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile

  execute "diffthis"
  execute "wincmd l"
  execute "diffthis"
  execute "wincmd h"
  execute "normal 1G"
endfunction

