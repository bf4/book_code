#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
class Integer
  
  DEGREE = [""] + %w[thousand million billion trillion quadrillion 
  quintillion sextillion septillion octillion nonillion decillion
  undecillion duodecillion tredecillion quattuordecillion
  quindecillion sexdecillion septdecillion novemdecillion
  vigintillion unvigintillion duovigintillion trevigintillion
  quattuorvigintillion quinvigintillion sexvigintillion 
  septvigintillion octovigintillion novemvigintillion trigintillion 
  untregintillion duotrigintillion googol]

  def teen
    case self
    when 0: "ten"
    when 1: "eleven"
    when 2: "twelve"
    else    in_compound + "teen"
    end
  end

  def ten
    case self
    when 1: "ten"
    when 2: "twenty"
    else    in_compound + "ty"
    end
  end

  def in_compound
    case self
    when 3: "thir"
    when 5: "fif"
    when 8: "eigh"
    else    to_en
    end
  end

  def to_en(ands=true)
    small_nums = [""] + %w[one two three four five six seven eight nine]
    if self < 10: small_nums[self]
    elsif self < 20: (self % 10).teen
    elsif self < 100:
      result = (self/10).ten
      result += "-" if (self % 10) != 0
      result += (self % 10).to_en
      return result
    elsif self < 1000
      if self%100 != 0 and ands
        (self/100).to_en(ands)+" hundred and "+(self%100).to_en(ands)
      else ((self/100).to_en(ands)+
        " hundred "+(self%100).to_en(ands)).chomp(" ")
      end
    else
      front,back = case (self.to_s.length) % 3
        when 0: [0..2,3..-1].map{|i| self.to_s[i]}.map{|i| i.to_i}
        when 2: [0..1,2..-1].map{|i| self.to_s[i]}.map{|i| i.to_i}
        when 1: [0..0,1..-1].map{|i| self.to_s[i]}.map{|i| i.to_i}
        end
      result = front.to_en(false) + " " + DEGREE[(self.to_s.length-1)/3]
      result += if back > 99: ", "
                elsif back > 0: ands ? " and " : " "
                else ""
                end
      result += back.to_en(ands)
      return result.chomp(" ")
    end
  end

end

medium_nums = (1..999).map{|i| i.to_en}
print "The alphabetically first number (1-999) is: "
puts first = medium_nums.min.dup
first_degree = Integer::DEGREE[1..-1].min
first << " " + first_degree
puts "The first non-empty degree word (10**3-10**100) is: "+first_degree
next_first = (["and"] + medium_nums).min
first << " " + next_first
puts "The next first word (numbers 1-999 + 'and') is: "+next_first 
if next_first == "and"
  puts "Since the last word was 'and', we need an odd number in 1..99."
  odd_nums = []
  (0..98).step(2){|i| odd_nums << medium_nums[i]}
  first_odd = odd_nums.min
  puts "The first one is: "+first_odd
  first << " " + first_odd
else # This will never happen; I can't bring myself to write it.
end
puts "Our first odd number, then, is #{first}."
