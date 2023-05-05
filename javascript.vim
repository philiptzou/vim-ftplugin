setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

if exists('*AutoFix')
  finish
endif

func! AutoFix(...)
  :w
  let winview = winsaveview()
  let path = expand("%:p")
  let path = fnameescape(path)
  call system("npx eslint --fix ".path)
  silent exec "e"
  call winrestview(winview)
endfunc

command! AutoFix call AutoFix()
:ab autofix AutoFix
:ab af AutoFix
