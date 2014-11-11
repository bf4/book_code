require 'dl/import'

class LiveMIDI
  ON  = 0x90
  OFF = 0x80
  PC  = 0xC0

  def initialize
    open
  end

  def note_on(channel, note, velocity=64)
    message(ON | channel, note, velocity)
  end

  def note_off(channel, note, velocity=64)
    message(OFF | channel, note, velocity)
  end

  def program_change(channel, preset)
    message(PC | channel, preset)
  end
end

if RUBY_PLATFORM.include?('mswin')
  class LiveMIDI
    # Windows code here
  end
elsif RUBY_PLATFORM.include?('darwin')
  class LiveMIDI
    # Mac code here
  end
elsif RUBY_PLATFORM.include?('linux')
  class LiveMIDI
    # Linux code here
  end
else
  raise "Couldn't find a LiveMIDI implementation for your platform"
end
