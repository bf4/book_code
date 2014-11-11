class Animation
  attr_reader :frame, :width, :height, :objects
    
  def initialize(width, height)
    @width     = width
    @height    = height
    @objects   = []
    @frame     = 0
    @step_callbacks = []
    @at_callbacks = Hash.new {|hash, key| hash[key] = [] }
  end

  def add(obj)
    @objects.push(obj)
  end

  def run(dir, frames)
    Dir.mkdir(dir) rescue nil
    digits = frames.to_s.size
      
    frames.times do |n|
      @frame = n
      file = frame_id(n, digits)
      filename = File.join(dir, file)

      run_callbacks
      render(filename)
    end
  end

  def frame_id(frame, digits)
    sprintf("%.#{digits}d", frame)
  end

  def at(frame, &callback)
    @at_callbacks[frame].push(callback)
  end
end
