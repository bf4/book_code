#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Ruby 1.9.2 adds utc_offset and zone to Time, but marshaling only
# preserves utc_offset. Preserve zone also, even though it may not
# work in some edge cases.
if Time.local(2010).zone != Marshal.load(Marshal.dump(Time.local(2010))).zone
  class Time
    class << self
      alias_method :_load_without_zone, :_load
      def _load(marshaled_time)
        time = _load_without_zone(marshaled_time)
        time.instance_eval do
          if zone = defined?(@_zone) && remove_instance_variable('@_zone')
            ary = to_a
            ary[0] += subsec if ary[0] == sec
            ary[-1] = zone
            utc? ? Time.utc(*ary) : Time.local(*ary)
          else
            self
          end
        end
      end
    end

    alias_method :_dump_without_zone, :_dump
    def _dump(*args)
      obj = dup
      obj.instance_variable_set('@_zone', zone)
      obj.send :_dump_without_zone, *args
    end
  end
end
