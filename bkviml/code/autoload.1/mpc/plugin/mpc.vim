"START:firstRevision
"START:beginning
function! OpenMPC()
"END:firstRevision
  if(bufexists('mpc.mpdv'))
    let mpcwin = bufwinnr('mpc.mpdv')
"END:beginning
"START:middle
    if(mpcwin == -1)
      execute "sbuffer " . bufnr('mpc.mpdv')
    else
      execute mpcwin . 'wincmd w'
      return
    endif
"END:middle
"START:ending
  else
    execute "new mpc.mpdv"
  endif
"START:firstRevision
"START:callFunction
  call mpc#DisplayPlaylist() 
"END:callFunction
endfunction
"END:ending
"END:firstRevision
