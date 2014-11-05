#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
def Regexp.build(*args)
  ranges, numbers = args.partition{|item| Range === item}
  re = ranges.map{|r| r.to_re } + numbers.map{|n| /0*#{n}/ }
  /^#{Regexp.union(*re)}$/
end

class Range
  def to_re
    # normalize the range format; we want end inclusive, integer ranges
    # this part passes the load off to a newly built range if needed.
    if exclude_end?
      return( (first.to_i..last.to_i - 1).to_re )
    elsif ! (first + last).kind_of?(Integer)
      return( (first.to_i .. last.to_i).to_re )
    end

    # Deal with ranges that are wholly or partially negative. If range is
    # only partially negative, split in half and get two regexen. join them
    # together for the finish. If the range is wholly negative, make it
    # positive, and then add a negative sign to the regexp
    if first < 0 and last < 0
      # return a negatized version of the Regexp
      return /-#{(-last..-first).to_re}/
    elsif first < 0
      neg = (first..-1).to_re
      pos = (0..last).to_re
      return /(?:#{neg}|#{pos})/
    end    

    ### First, create an array of new ranges that are more
    ### suited to regex conversion.

    # a and z will be the remainders of the endpoints of the range
    # as we slice it
    a, z = first, last

    # build the first part of the list of new ranges.
    list1 = []
    num = first
    until num > z
      a = num # recycle the value
      # get the first power of ten that leaves a remainder
      v = 10
      v *= 10 while num % v == 0 and num != 0
      # compute the next value up
      num += v - num % v
      # store the value unless it's too high
      list1 << (a..num-1) unless num > z
    end

    # build the second part of the list; counting down.
    list2 = []
    num = last + 1
    until num < a
      z = num - 1 # recycle the value
      # slice to the nearest power of ten
      v = 10
      v *= 10 while num % v == 0 and num != 0
      # compute the next value down
      num -= num % v
      # store the value if it fits
      list2 << (num..z) unless num < a
    end
    # get the chewy center part, if needed
    center = a < z ? [a..z] : []
    # our new list
    list = list1 + center + list2.reverse

    ### Next, convert each range to a Regexp.
    list.map! do |rng|
      a, z = rng.first.to_s, rng.last.to_s
      a.split(//).zip(z.split(//)).map do |(f,l)|
        case
          when f == l then f
          when f.to_i + 1 == l.to_i then "[%s%s]" % [f,l]
          when f+l == "09" then "\\d"
          else
            "[%s-%s]" % [f,l]
        end
      end.join # returns the Regexp for *that* range
    end

    ### Last, return the final Regexp
    /0*#{ list.join("|") }/
  end
end
