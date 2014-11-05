#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# Copyright (c) 2008 [Sur http://expressica.com]

class SimpleCaptchaData < ActiveRecord::Base
  set_table_name "simple_captcha_data"
  
  class << self
    def get_data(key)
      data = find_by_key(key) || new(:key => key)
    end
    
    def remove_data(key)
      clear_old_data
      data = find_by_key(key)
      data.destroy if data
    end
    
    def clear_old_data(time = 1.hour.ago)
      return unless Time === time
      destroy_all("updated_at < '#{time.to_s(:db)}'")
    end
  end
  
end
