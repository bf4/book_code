"START:secondGetPlaylist
"START:secondGetPlaylistBeginning
function! mpc#GetPlaylist()
  let command = "mpc --format '%position% @%artist% @%album% @%title%' playlist"
  let [results, playlist] = [split(system(command), '\n'), []]
  let maxLengths = {'position': [], 'artist': [], 'album': []}
  "END:secondGetPlaylistBeginning

  "START:secondGetPlaylistPlaylistLoop
  for item in results
    call add(playlist, mpc#EncodeSong(item))
  endfor
  "END:secondGetPlaylistPlaylistLoop

  "START:secondGetPlaylistLengthLoop
  for track in playlist
    call add(maxLengths['position'], len(track.position))
    call add(maxLengths['artist'], len(track.artist))
    call add(maxLengths['album'], len(track.album))
  endfor
  "END:secondPlaylistLengthLoop

  "START:sortSecondGetPlaylist
  call sort(maxLengths.position, "LargestNumber")
  call sort(maxLengths.artist, "LargestNumber")
  call sort(maxLengths.album, "LargestNumber")
  "END:sortSecondGetPlaylist

  "START:secondGetPlaylistPaddingLoop
  for track in playlist
    if(maxLengths.position[-1] + 1 > len(track.position))
      let track.position = repeat(' ',
            \ maxLengths.position[-1] - len(track.position))
            \ . track.position
    endif
    let track.position .= ' '
    let track.artist .= repeat(' ',
      \ maxLengths['artist'][-1] + 2 - len(track.artist))
    let track.album .= repeat(' ',
      \ maxLengths['album'][-1] + 2 - len(track.album))
  endfor
  "END:secondGetPlaylistPaddingLoop

  "START:secondGetPlaylistEnding
  return playlist
endfunction
"END:secondGetPlaylistEnding
"END:secondGetPlaylist

"START:sortingFunction
function! LargestNumber(no1, no2)
  return a:no1 == a:no2 ? 0 : a:no1 > a:no2 ? 1 : -1
endfunction
"END:sortingFunction

"START:syntaxFunctions
function! mpc#EncodeSong(item)
  let item = split(a:item, " @")
  let song = {'position': item[0],
        \ 'artist': '@ar' . item[1] . 'ar@',
        \ 'album': '@al' . item[2] . 'al@',
        \ 'title': '@ti' . item[3] . 'ti@'}
  return song
endfunction

function! mpc#DecodeSong(item)
  let line_items = split(substitute(a:item, ' \{2,}', ' ', 'g'), ' @')
  let song =  {'position': line_items[0], 
        \ 'artist': line_items[1][2:-4],
        \ 'album': line_items[2][2:-4],
        \ 'title': line_items[3][2:-4]}
  return song
endfunction
"END:syntaxFunctions

"START:newDisplayPlaylist
function! mpc#DisplayPlaylist()
  let playlist = mpc#GetPlaylist()

  for track in playlist
    let output = track.position . " "
          \ . track.artist
          \ . track.album
          \ . track.title
    if(playlist[0].position == track.position)
      execute "normal! 1GdGI" . output
    else
      call append(line('$'), output)
    endif
  endfor
endfunction
"END:newDisplayPlaylist

function! mpc#PlaySong(no)
  let song = split(getline(a:no), " ")
  let results = split(system("mpc --format '%title% (%artist%)' play "
        \ . song[0]), "\n")
  
  let message = '[mpc] NOW PLAYING: ' . results[0]
  echomsg message
endfunction
