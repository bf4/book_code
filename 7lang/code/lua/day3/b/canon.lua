song = require 'notation'

song.set_tempo(50)

song.part{
   D3s,  Fs3s, A3s,  D4s,
   A2s,  Cs3s, E3s,  A3s,
   B2s,  D3s,  Fs3s, B3s,
   Fs2s, A2s,  Cs3s, Fs3s,

   G2s,  B2s,  D3s,  G3s,
   D2s,  Fs2s, A2s,  D3s,
   G2s,  B2s,  D3s,  G3s,
   A2s,  Cs3s, E3s,  A3s,
}

song.part{
   Fs4ed,           Fs5s,
   Fs5s, G5s, Fs5s, E5s,
   D5ed,            D5s,
   D5s,  E5s, D5s,  Cs5s,

   B4q,
   D5q,
   D5s,  C5s, B4s,  C5s,
   A4q
}

song.go()
