NOTE_DOWN = 0x90
NOTE_UP   = 0x80
VELOCITY  = 0x7f

function play(note)
   midi_send(NOTE_DOWN, note, VELOCITY)
   while os.clock() < 1 do end
   midi_send(NOTE_UP, note, VELOCITY)
end

play(60)
