"START:functionStatusline
"START:cmd
function! GetMPCStatusline()
  let cmd = "mpc status"
  let result = split(system(cmd), '\n')
"END:cmd

"START:ternary
  let status = len(result) == 3 ? result[2] : result[0] 
"END:ternary

"START:variables
  let [s:count, s:settings] = 
        \ [len(split(system('mpc playlist'), '\n')),
        \ split(status, '   ')]
"END:variables

"START:statusline
  let s:statusline = " " 
        \ . s:settings[1] . " --- " 
        \ . s:settings[2] . " ---%=" 
        \ . s:count . " songs "
"END:statusline

"START:return
  return s:statusline
endfunction
"END:return
"END:functionStatusline

"START:end
"START:bufferType
set buftype=nofile
"END:bufferType
setlocal statusline=%!GetMPCStatusline()
"END:end

