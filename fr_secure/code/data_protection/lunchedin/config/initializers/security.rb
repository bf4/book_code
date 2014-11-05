#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'encryptor'

if RAILS_ENV['production']
  ActiveRecord::Base.encryption_key = File::read('/etc/lunchedin.key')
else
  # test and development configuration
  ActiveRecord::Base.encryption_key = '1234567890abcdef'
end