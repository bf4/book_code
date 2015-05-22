syntax region mpdArtist matchgroup=mpdArtistSyn start=/@ar/ end=/ar@/ concealends
syntax region mpdAlbum matchgroup=mpdAlbumSyn start=/@al/ end=/al@/ concealends
syntax region mpdTitle matchgroup=mpdTitleSyn start=/@ti/ end=/ti@/ concealends

highlight default mpdArtist ctermbg=234 ctermfg=lightgreen
                          \ guibg=#1c1c1c guifg=#5fff87
highlight default mpdAlbum ctermbg=234 ctermfg=lightblue
                          \ guibg=#1c1c1c guifg=#5fd7ff
highlight default mpdTitle ctermbg=234 ctermfg=lightmagenta
                          \ guibg=#1c1c1c guifg=#ffafff
