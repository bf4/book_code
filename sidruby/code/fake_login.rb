#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'digest/md5'

class FakeLogin
  def initialize(fname)
    @fname = fname
    @db = {}
    load
  end

  def set_phrase(user, phrase)
    load
    @db[user.to_s] = Digest::MD5.hexdigest(phrase.to_s)
    save
  end

  def get_user(user, phrase)
    load
    if @db[user.to_s] == Digest::MD5.hexdigest(phrase.to_s)
      user
    else
      nil
    end
  end

  def save
    tmp_fname = @fname + '.tmp'
    File.open(tmp_fname, 'w') do |fp|
      fp.write(Marshal.dump(@db))
    end
    File.rename(tmp_fname, @fname)
  end

  def load
    File.open(@fname) do |fp|
      @db = Marshal.load(fp.read)
    end
  rescue
  end
end

if __FILE__ == $0
  filename = ARGV.shift || raise("#{$0} filename username")
  user = ARGV.shift || raise("#{$0} filename username")
  phrase = gets.chomp
  db = FakeLogin.new(filename)
  db.set_phrase(user, phrase)
end