#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# Copyright (c) 2008 [Sur http://expressica.com]

class SimpleCaptchaController < ActionController::Base

  include SimpleCaptcha::ImageHelpers

  def simple_captcha  #:nodoc
    send_data(
      generate_simple_captcha_image(
        :image_style => params[:image_style],
        :distortion => params[:distortion], 
        :simple_captcha_key => params[:simple_captcha_key]),
      :type => 'image/jpeg',
      :disposition => 'inline',
      :filename => 'simple_captcha.jpg')
  end

end
