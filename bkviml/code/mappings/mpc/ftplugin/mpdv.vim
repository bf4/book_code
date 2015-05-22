function! GetMPCStatusline()
  let command = "mpc status"
  let result = split(system(command), '\n')

  let status = len(result) == 3 ? result[2] : result[0] 

  let [s:count, s:settings] = 
        \ [len(split(system('mpc playlist'), '\n')),
        \ split(status, '   ')]

  let s:statusline = "%= " 
        \ . s:settings[1] . " --- " 
        \ . s:settings[2] . " --- " 
        \ . s:count . " songs "

  return substitute(s:statusline, " ", "\ ", "g")
endfunction

set buftype=nofile
setlocal conceallevel=3
setlocal concealcursor=nvic
setlocal statusline=%!GetMPCStatusline()

"START:commandPlaySelected
command! -buffer PlaySelectedSong call mpc#PlaySong(line("."))
"END:commandPlaySelected
"START:commandToggleRandomRepeat
command! -buffer ToggleRandom     call mpc#ToggleRandom()
command! -buffer ToggleRepeat     call mpc#ToggleRepeat()
"END:commandToggleRandomRepeat

"START:mappings
nnoremap <silent>             <plug>MpcToggleplayback   :TogglePlayback<cr>
nnoremap <silent> <buffer>    <c-x>                     :PlaySelectedSong<cr>
nnoremap <silent> <buffer>    <c-a>                     :ToggleRandom<cr>
nnoremap <silent> <buffer>    <c-e>                     :ToggleRepeat<cr>
"END:mappings
"START:mapToPlugToggleplayback
if !hasmapto("<plug>MpcToggleplayback")
  nmap <leader>p   <plug>MpcToggleplayback
endif
"END:mapToPlugToggleplayback
