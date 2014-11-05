#---
# Excerpted from "The Cucumber Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/hwcuc for more book information.
#---
require 'fileutils'
class TransactionQueue

  def initialize
    FileUtils.rm_rf('messages')
    FileUtils.mkdir_p('messages')
    @next_id = 1
  end

  def write(transaction)
    File.open("messages/#{@next_id}", 'w') { |f| f.puts(transaction) }
    @next_id += 1
  end

  def read
    next_message_file = Dir['messages/*'].first
    return unless next_message_file
    yield File.read(next_message_file)
    FileUtils.rm_rf(next_message_file)
  end

end
