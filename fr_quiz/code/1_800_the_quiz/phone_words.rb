#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


require "enumerator"
class PhoneDictionary
  def self.encode( letter )
    case letter.downcase
    when "a", "b", "c"      then "2"
    when "d", "e", "f"      then "3"
    when "g", "h", "i"      then "4"
    when "j", "k", "l"      then "5"
    when "m", "n", "o"      then "6"
    when "p", "q", "r", "s" then "7"
    when "t", "u", "v"      then "8"
    when "w", "x", "y", "z" then "9"
    end
  end



  def initialize( word_file )
    @words = Hash.new { |dict, digits| dict[digits] = Array.new }
    ("0".."9").each { |n| @words[n] << n }
    %w{a i}.each { |word| @words[self.class.encode(word)] << word }
    
    warn "Loading dictionary..." if $DEBUG
    read_dictionary(word_file)
  end



  def self.match( number, digits )
    if number[0, digits.length] == digits
      number[digits.length..-1]
    else
      nil
    end
  end



  def number_to_words( phone_number )
    warn "Searching..." if $DEBUG
    results = search(phone_number)
    
    warn "Preparing output..." if $DEBUG
    results.map! { |chunks| chunks_to_strings(chunks) }
    results.flatten!
    results.reject! { |words| words =~ /\d-\d/ }
    results.sort!
    
    results
  end


  private


  def read_dictionary( dictionary )
    File.foreach(dictionary) do |word|
      word.downcase!
      word.delete!("^a-z")
      
      next if word.empty? or word.size < 2 or word.size > 7
      
      chars  = word.enum_for(:each_byte)
      digits = chars.map { |c| self.class.encode(c.chr) }.join
      
      @words[digits] << word unless @words[digits].include?(word)
    end
  end



  def search( number, chunks = Array.new )
    @words.inject(Array.new) do |all, (digits, words)|
      if remainder = self.class.match(number, digits)
        new_chunks = (chunks.dup << words)
        if remainder.empty?
          all.push(new_chunks)
        else
          all.push(*search(remainder, new_chunks))
        end
      else
        all
      end
    end
  end

  

  def chunks_to_strings( chunks )
    chunk, *new_chunks = chunks.dup
    if new_chunks.empty?
      chunk.map { |word| word.upcase }
    else
      chunk.map do |word|
        chunks_to_strings(new_chunks).map { |words| "#{word.upcase}-#{words}" }
      end.flatten
    end
  end



end


  


if __FILE__ == $0
  dictionary = if ARGV.first == "-d"
    ARGV.shift
    PhoneDictionary.new(ARGV.shift)
  else
    PhoneDictionary.new("/usr/share/dict/words")
  end

  ARGF.each_line do |phone_number|
    puts dictionary.number_to_words(phone_number.delete("^0-9"))
  end
end

