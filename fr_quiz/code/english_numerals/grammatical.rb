#!/usr/bin/ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

class Integer

  Ones = %w[ zero one two three four five six seven eight nine ]
  Teen = %w[ ten eleven twelve thirteen fourteen fifteen
             sixteen seventeen eighteen nineteen ]
  Tens = %w[ zero ten twenty thirty forty fifty
             sixty seventy eighty ninety ]
  Mega = %w[ none thousand million billion ]

  def to_english
    places = to_s.split(//).collect {|s| s.to_i}.reverse
    name = []
    ((places.length + 2) / 3).times do |p|
      strings = Integer.trio(places[p * 3, 3])
      name.push(Mega[p]) if strings.length > 0 and p > 0
      name += strings
    end
    name.push(Ones[0]) unless name.length > 0
    name.reverse.join(" ")
  end

  private

  def Integer.trio(places)
    strings = []
    if places[1] == 1
      strings.push(Teen[places[0]])
    elsif places[1] and places[1] > 0
      strings.push(places[0] == 0 ? Tens[places[1]] :
                   "#{Tens[places[1]]}-#{Ones[places[0]]}")
    elsif places[0] > 0
      strings.push(Ones[places[0]])
    end
    if places[2] and places[2] > 0
      strings.push("hundred", Ones[places[2]])
    end
    strings
  end
end

# If there are command-line args, just print out English names.
if ARGV.length > 0
  ARGV.each {|arg| puts arg.to_i.to_english}
  exit 0
end

# Return the name of the number in the specified range that is the
# lowest lexically.
def minimum_english(start, stop, incr)
  min_name = start.to_english
  start.step(stop, incr) do |i|
    name = i.to_english
    min_name = name if min_name > name
  end
  min_name
end

# Find the lowest phrase for each 3-digit cluster of place-values.
# The lowest overall string must be composed of elements from this list.
components =
  [ minimum_english(10**9, 10**10, 10**9),
    minimum_english(10**6, 10**9 - 1, 10**6),
    minimum_english(10**3, 10**6 - 1, 10**3),
    minimum_english(10**0, 10**3 - 1, 2) ]

$result = components[-1]
def search_combinations(list, selected = [])
  if elem = (list = list.dup).shift
    if list.empty?
      # Always include the final element from list in the selection.
      string = selected.dup.push(elem).join(" ")
      $result = string if $result > string
    else
      search_combinations(list, selected)
      search_combinations(list, selected.dup.push(elem))
    end
  end
  $result
end

puts search_combinations(components)
