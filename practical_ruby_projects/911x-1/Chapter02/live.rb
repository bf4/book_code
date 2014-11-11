require 'music-53'

bpm(120)
midi = LiveMIDI.use(@bpm)
melody = midi.instrument(40)
drums = midi.instrument(0, 9)
bang melody.pattern(60, "4-00 4==2")
bang drums.pattern(36, "x--- xx--")
bang drums.pattern(40, "--x-")
