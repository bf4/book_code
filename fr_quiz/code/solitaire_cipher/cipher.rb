#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
class Cipher
  def self.chars_to_text( chars )
    chars.map { |char| (char + ?A - 1).chr }.join.scan(/.{5}/).join(" ")
  end

  def self.normalize( text )
    text =  text.upcase.delete("^A-Z")
    text += ("X" * (text.length % 5))
    text.scan(/.{5}/).join(" ")
  end
  
  def self.text_to_chars( text )
    text.delete("^A-Z").split("").map { |char| char[0] - ?A + 1 }
  end
  
  def initialize( keystream )
    @keystream = keystream
  end
  
  def decrypt( message )
    crypt(message, :-)
  end
  
  def encrypt( message )
    crypt(message, :+)
  end
  
  private
  
  def crypt( message, operator )
    c = self.class
    
    message   = c.text_to_chars(c.normalize(message))
    keystream = c.text_to_chars(message.map { @keystream.next_letter }.join)
    
    crypted = message.map do |char|
      ((char - 1).send(operator, keystream.shift) % 26) + 1
    end
    
    c.chars_to_text(crypted)
  end
end
