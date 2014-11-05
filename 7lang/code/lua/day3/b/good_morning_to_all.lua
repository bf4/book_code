-- START:song
notes = {
   'D4q',
   'E4q',
   'D4q',
   'G4q',
   'Fs4h'
}
-- END:song

-- START:play_song
scheduler = require 'scheduler'
notation  = require 'notation'

function play_song()
   for i = 1, #notes do
      local symbol = notation.parse_note(notes[i])
      notation.play(symbol.note, symbol.duration)
   end
end
-- END:play_song

-- START:run
scheduler.schedule(0.0, coroutine.create(play_song))
scheduler.run()
-- END:run
