#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
class Array
  def random_member(&block)
    return select(&block).random_member if block
    return self[rand(size)]
  end
  def count(&block)
    return select(&block).size
  end
end

class Person
  attr_reader :first, :family
  def initialize(first, family)
    @first, @family = first, family
  end
  def to_s() "#{first} #{family}" end
end

class AssignSanta
  def initialize(persons)
    @persons = persons.dup
    @santas = persons.dup
    @families = persons.collect {|p| p.family}.uniq
    @families.each do |f|
      if santa_surplus(f) < 0
        raise "No santa configuration possible"
      end
    end
  end
  
  # Key function -- extra santas available for a family
  #    if this is negative -- no santa configuration is possible
  #    if this is 0 -- next santa must be assigned to this family
  def santa_surplus(family)
    return @santas.count {|s| s.family != family} -
           @persons.count {|p| p.family == family}
  end

  def call
    while @persons.size() > 0
      family = @families.detect do |f|
        santa_surplus(f)==0 and
          @persons.count{|p| p.family == f} > 0
      end
      person = @persons.random_member do |p|
        family == nil || p.family == family
      end
      santa = @santas.random_member do |s|
        s.family != person.family
      end
      yield(person, santa)
      @persons.delete(person)
      @santas.delete(santa)
    end
  end
end

people = STDIN.read.split("\n").map do |line|
  first, family = line.chomp.split(' ', 2)
  Person.new(first, family)
end

assigner = AssignSanta.new(people)
assigner.call do |person, santa|
  puts "#{person} -> #{santa}"
end
