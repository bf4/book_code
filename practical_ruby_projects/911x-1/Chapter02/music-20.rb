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

class NoMIDIDestinations < Exception; end

if RUBY_PLATFORM.include?('mswin')

  class LiveMIDI
    module C
      extend DL::Importable
      dlload 'winmm'

      extern "int midiOutOpen(HMIDIOUT*, int, int, int, int)"
      extern "int midiOutClose(int)"
      extern "int midiOutShortMsg(int, int)"
    end

    def open
      @device = DL.malloc(DL.sizeof('I'))
      C.midiOutOpen(@device, -1, 0, 0, 0)
    end

    def close
      C.midiOutClose(@device.ptr.to_i)
    end

    def message(one, two=0, three=0)
      message = one + (two << 8) + (three << 16)
      C.midiOutShortMsg(@device.ptr.to_i, message)
    end
  end

elsif RUBY_PLATFORM.include?('darwin')

  class LiveMIDI
    module C
      extend DL::Importable
      dlload '/System/Library/Frameworks/CoreMIDI.framework/Versions/Current/CoreMIDI'

      extern "int MIDIClientCreate(void *, void *, void *, void *)"
      extern "int MIDIClientDispose(void *)"
      extern "int MIDIGetNumberOfDestinations()"
      extern "void * MIDIGetDestination(int)"
      extern "int MIDIOutputPortCreate(void *, void *, void *)"
      extern "void * MIDIPacketListInit(void *)"
      extern "void * MIDIPacketListAdd(void *, int, void *, int, int, int, void *)"
      extern "int MIDISend(void *, void *, void *)"
    end

    module CF
      extend DL::Importable
      dlload '/System/Library/Frameworks/CoreFoundation.framework/Versions/Current/CoreFoundation'

      extern "void * CFStringCreateWithCString (void *, char *, int)"
    end

    def open
      client_name = CF.cFStringCreateWithCString(nil, "RubyMIDI", 0)
      @client = DL::PtrData.new(nil)
      C.mIDIClientCreate(client_name, nil, nil, @client.ref);

      port_name = CF.cFStringCreateWithCString(nil, "Output", 0)
      @outport = DL::PtrData.new(nil)
      C.mIDIOutputPortCreate(@client, port_name, @outport.ref);

      num = C.mIDIGetNumberOfDestinations()
      raise NoMIDIDestinations if num < 1
      @destination = C.mIDIGetDestination(0)
    end

    def close
      C.mIDIClientDispose(@client)
    end

    def message(*args)
      format = "C" * args.size
      bytes = args.pack(format).to_ptr
      packet_list = DL.malloc(256)
      packet_ptr  = C.mIDIPacketListInit(packet_list)
      # Pass in two 32 bit 0s for the 64 bit time
      packet_ptr  = C.mIDIPacketListAdd(packet_list, 256, packet_ptr, 0, 0, args.size, bytes)
      C.mIDISend(@outport, @destination, packet_list)
    end
  end

elsif RUBY_PLATFORM.include?('linux')

  class LiveMIDI
    module C
      extend DL::Importable
      dlload 'libasound.so'

      extern "int snd_rawmidi_open(void*, void*, char*, int)"
      extern "int snd_rawmidi_close(void*)"
      extern "int snd_rawmidi_write(void*, void*, int)"
      extern "int snd_rawmidi_drain(void*)"
    end

    def open
      @output = DL::PtrData.new(nil)
      C.snd_rawmidi_open(nil, @output.ref, "virtual", 0)
    end

    def close
      C.snd_rawmidi_close(@output)
    end

    def message(*args)
      format = "C" * args.size
      bytes = args.pack(format).to_ptr
      C.snd_rawmidi_write(@output, bytes, args.size)
      C.snd_rawmidi_drain(@output)
    end
  end

else
  raise "Couldn't find a LiveMIDI implementation for your platform"
end

class Timer
  def initialize(resolution)
    @resolution = resolution
    @queue = []

    Thread.new do
      while true
        dispatch
        sleep(@resolution)
      end
    end
  end

  def at(time, &block)
    time = time.to_f if time.kind_of?(Time)
    @queue.push [time, block]
  end

  private
  def dispatch
    now = Time.now.to_f
    ready, @queue = @queue.partition{|time, proc|  time <= now }
    ready.each {|time, proc| proc.call(time) }
  end
end

class Metronome
  def initialize(bpm)
    @midi = LiveMIDI.new
    @midi.program_change(0, 115)
    @interval = 60.0 / bpm
    @timer = Timer.new(@interval/10)
    now = Time.now.to_f
    register_next_bang(now)
  end
	
  def register_next_bang(time)
    @timer.at(time) do |this_time|
      register_next_bang(this_time + @interval)
      bang
    end
  end

  def bang
    @midi.note_on(0, 84, 60)
    sleep(0.1)
    @midi.note_off(0, 84, 60)
  end
end

metro = Metronome.new(120)
sleep(10)