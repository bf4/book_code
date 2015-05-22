function! OpenMPC()
  let cmd = "mpc --format '%title% (%artist%)' current"
  echomsg system(cmd)[:-2]
endfunction
