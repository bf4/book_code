"START:map
map o   O " (OK -- maybe don't try that one)
"END:map

"START:modeMap
" Map m to run Ctrl-d (half-page-down) in normal mode
nmap m   <c-d>

" Map ' to type the XML 'right single quote' entity in insert mode
imap '   &#8217;
"END:modeMap

"START:nmap
nmap o  oHello! <esc>A
"END:nmap

"START:nmapRecursive
nmap o  o<esc>oHello! <esc>A
"END:nmapRecursive

"START:nmapNoRecursive
nnoremap o  o<esc>oHello! <esc>A
"END:nmapNoRecursive

"START:mapToCommand
nnoremap v  :vsplit<cr>
"END:mapToCommand

"START:mapToCommandSilent
nnoremap <silent> v  :vsplit<cr>
"END:mapToCommandSilent

"START:mapToCommandSilentBufferSpecific
nnoremap <buffer> <silent> v  :vsplit<cr>
"END:mapToCommandSilentBufferSpecific

"START:mapToPlug
nnoremap <silent> <buffer> <plug>MpcPlayselectedsong   :PlaySelectedSong<cr>
"END:mapToPlug

"START:mapToPlugMapping
nmap <leader>p   <plug>MpcPlayselectedsong
"END:mapToPlugMapping

"START:scriptLocalFunction
function! s:ColorfulCuteAnimals()
  let animals = ["Phil", "Tom", "Barb", "Bob", "Stacy", "Peary", "Mark",
               \ "Michael"]
  for a in animals
    echom a . " is a tiny animal."
  endfor
endfunction
"END:scriptLocalFunction

"START:scriptLocalMapping
nnoremap <leader>a   :call <SID>ColorfulCuteAnimals()<cr>
"END:scriptLocalMapping

"START:scriptLocalMappingWithoutCR
nnoremap <leader>a   :call <SID>ColorfulCuteAnimals()

" When we run the mapping, the command line is populated with something like:

:call <SNR>45_ColorfulCuteAnimals()
"END:scriptLocalMappingWithoutCR

"START:hasMapTo
if !hasmapto('<c-e'>)
  " Yep -- we can define a mapping to <c-e> (Ctrl-e).
endif
"END:hasMapTo
