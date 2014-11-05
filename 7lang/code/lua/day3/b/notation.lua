-- START:note
local function note(letter, octave)
   local notes = {
      C  = 0,
      Cs = 1,
      D  = 2,
      Ds = 3,
      E  = 4,
      F  = 5,
      Fs = 6,
      G  = 7,
      Gs = 8,
      A  = 9,
      As = 10,
      B  = 11
   }

   local notes_per_octave = 12

   return (octave + 1) * notes_per_octave + notes[letter]
end
-- END:note

-- START:duration
local tempo = 100

local function duration(value)
   local quarter   = 60 / tempo
   local durations = {
      h  = 2.0,
      q  = 1.0,
      ed = 0.75,
      e  = 0.5,
      s  = 0.25,
   }

   return durations[value] * quarter
end
-- END:duration

-- START:parse_note
local function parse_note(s)
   local letter, octave, value =
      string.match(s, "([A-Gs]+)(%d+)(%a+)")

   if not (letter and octave and value) then
      return nil
   end

   return {
      note     = note(letter, octave),
      duration = duration(value)
   }
end
-- END:parse_note

-- START:play
local scheduler = require 'scheduler'

local NOTE_DOWN = 0x90
local NOTE_UP   = 0x80
local VELOCITY  = 0x7f

local function play(note, duration)
   midi_send(NOTE_DOWN, note, VELOCITY)
   scheduler.wait(duration)
   midi_send(NOTE_UP, note, VELOCITY)
end
-- END:play

--[[
-- START:firstmodule
return {
   parse_note = parse_note,
   play = play
}
-- END:firstmodule
--]]

-- START:meta
local mt = {
   __index = function(t, s)
      local result = parse_note(s)
      return result or rawget(t, s)
   end
}

setmetatable(_G, mt)
-- END:meta

-- START:part
local function part(t)
   local function play_part()
      for i = 1, #t do
         play(t[i].note, t[i].duration)
      end
   end

   scheduler.schedule(0.0, coroutine.create(play_part))
end
-- END:part

-- START:go
local function set_tempo(bpm)
   tempo = bpm
end

local function go()
   scheduler.run()
end
-- END:go

-- START:module
return {
   parse_note = parse_note,
   play = play,
   part = part,
   set_tempo = set_tempo,
   go = go
}
-- END:module
