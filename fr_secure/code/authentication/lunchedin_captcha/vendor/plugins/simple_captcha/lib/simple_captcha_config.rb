#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# Copyright (c) 2008 [Sur http://expressica.com]

require 'digest/sha1'

module SimpleCaptcha #:nodoc
  module ConfigTasks #:nodoc

    private
    
    def simple_captcha_image_path #:nodoc
      "#{RAILS_ROOT}/vendor/plugins/simple_captcha/assets/images/simple_captcha/"
    end
    
    def simple_captcha_key #:nodoc
      session[:simple_captcha] ||= Digest::SHA1.hexdigest(Time.now.to_s + session.session_id.to_s)
    end
        
    def simple_captcha_value(key = simple_captcha_key) #:nodoc
      SimpleCaptchaData.get_data(key).value rescue nil
    end
    
    def simple_captcha_passed!(key = simple_captcha_key) #:nodoc
      SimpleCaptchaData.remove_data(key)
    end
  end  
end
