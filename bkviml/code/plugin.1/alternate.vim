function! OpenMPC()
  let cmd = "mpc --format '%position% %artist% / %album% / %title%' playlist"
  let playlist = split(system(cmd), '\n')

  new
  call append(0, playlist)
endfunction
