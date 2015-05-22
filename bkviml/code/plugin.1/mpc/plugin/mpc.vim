function! OpenMPC()
  let cmd = "mpc --format '%position% %artist% / %album% / %title%' playlist"
  let playlist = split(system(cmd), '\n') "<label id='code.plugin.1.playlist'/>

  new

  for track in playlist "<label id='code.plugin.1.beginfor'/>
    if(playlist[0] == track) "<label id='code.plugin.1.compare'/>
      execute "normal! I" . track "<label id='code.plugin.1.executenormal'/>
    else
      call append(line('$'), track) "<label id='code.plugin.1.append'/>
    endif
  endfor "<label id='code.plugin.1.endfor'/>
endfunction
