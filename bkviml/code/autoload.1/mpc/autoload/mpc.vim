START:display
function! mpc#DisplayPlaylist()
  let cmd = "mpc --format '%position% %artist% / %album% / %title%' playlist"
  let playlist = split(system(cmd), '\n')

  for track in playlist
    if(playlist[0] == track)
      execute "normal! 1GdGI" . track
    else
      call append(line('$'), track)
    endif
  endfor
endfunction
"END:display

"START:play
function! mpc#PlaySong(no)
  let song = split(getline(a:no), " ") "<label id='code.autoload.1.getline'/>
  let results = split(system("mpc --format '%title% (%artist%)' play " "<label id='code.autoload.1.results'/>
        \ . song[0]), "\n")
  let message = '[mpc] NOW PLAYING: ' . results[0] "<label id='code.autoload.1.message'/>
  echomsg message "<label id='code.autoload.1.echomsg'/>
endfunction
"END:play
