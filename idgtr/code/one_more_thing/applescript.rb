#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
module AppleScript
  class Command
    def initialize #(1)
      @lines = []
      @tells = 0
    end
	
    def method_missing(name, *args, &block)
      immediate = name.to_s.include? '!' #(2)
      param = args.shift
      script = name.to_s.chomp('!').gsub('_', ' ')
      script += %Q( #{param.inspect}) if param

      unless immediate #(3)
        script = 'tell ' + script
        @tells += 1
      end
      @lines << script
      if block_given? #(4)
        @has_block = true
        instance_eval &block
        go!
      elsif immediate && !@has_block
        go!
      else
        self
      end
    end
  end
end


module AppleScript
  class Command
    def go!
      clauses = @lines.map do |line|
        '-e "' + line.gsub('"', '\"') + '"'
      end.join(' ') + ' '
      clauses += '-e "end tell" ' * @tells
      `osascript #{clauses}`.chomp("\n")
    end
  end
end


module AppleScript
  def tell
    Command.new
  end
end
