#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
class Person
  attr_reader :first, :last
  attr_accessor :santa

  def initialize(line)
    m = /(\S+)\s+(\S+)/.match(line)
    raise unless m
    @first = m[1].capitalize
    @last = m[2].capitalize
  end

  def can_be_santa_of?(other)
    @last != other.last
  end
end

input = STDIN.read

people = []
input.each_line do |line|
  line.strip!
  people << Person.new(line) unless line.empty?
end

santas = people.dup
people.each do |person|
  person.santa = santas.delete_at(rand(santas.size))
end

people.each do |person|
  unless person.santa.can_be_santa_of? person
    candidates = people.select { |p|
      p.santa.can_be_santa_of?(person) && person.santa.can_be_santa_of?(p)
    }
    raise if candidates.empty?
    other = candidates[rand(candidates.size)]
    temp = person.santa
    person.santa = other.santa
    other.santa = temp
  end
end

people.each do |person|
  printf "%s %s -> %s %s\n", person.santa.first, person.santa.last, 
         person.first, person.last
end
