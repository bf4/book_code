"START:firstGetPlaylist
"START:firstGetPlaylistBeginning
function! mpc#GetPlaylist()
  let command = "mpc --format '%position% @%artist% @%album% @%title%' playlist"
  let [results, playlist] = [split(system(command), '\n'), []]
  let maxLengths = {'position': [], 'artist': [], 'album': []}
  "END:firstGetPlaylistBeginning

  "START:firstGetPlaylistLengthLoop
  for item in results
    let song = split(item, " @")
    let [position, artist, album, title] = song

    call add(maxLengths['position'], len(position))
    call add(maxLengths['artist'], len(artist))
    call add(maxLengths['album'], len(album))
  endfor
  "END:firstGetPlaylistLengthLoop

  "START:firstGetPlaylistSort
  call sort(maxLengths.position, "LargestNumber")
  call sort(maxLengths.artist, "LargestNumber")
  call sort(maxLengths.album, "LargestNumber")
  "END:firstGetPlaylistSort

  "START:firstGetPlaylistPaddingLoop
  for item in results
    let song = split(item, " @")
    let [position, artist, album, title] = song

    if(maxLengths.position[-1] + 1 > len(position))
      let position = repeat(' ',
            \ maxLengths.position[-1] - len(position))
            \ . position
    endif
    let position .= ' '
    let artist .= repeat(' ', maxLengths['artist'][-1] + 2 - len(artist))
    let album .= repeat(' ', maxLengths['album'][-1] + 2 - len(album))

    call add(playlist,
          \ {'position': position, 'artist': artist,
          \  'album': album, 'title': title})
  endfor
  "END:firstGetPlaylistPaddingLoop

  "START:firstGetPlaylistEnding
  return playlist
endfunction
"END:firstGetPlaylistEnding

"START:sortingFunction
function! LargestNumber(no1, no2)
  return a:no1 == a:no2 ? 0 : a:no1 > a:no2 ? 1 : -1
endfunction
"END:sortingFunction
  
"END:firstGetPlaylist

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
