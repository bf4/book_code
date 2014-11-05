#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'div'
require 'div/login'

class CountLoginDiv < Div::LoginDiv
  set_erb('countlogin.erb')

  def initialize(session, model, hint)
    super(session, model, hint)
    @retry_count = 0
  end
  attr_reader :retry_count

  def do_login(context, params)
    super(context, params)
    if @login.login?
      @retry_count = 0
    else
      @retry_count += 1
    end
    @login.guest_login if @retry_count > 3
  end

  def do_logout(context, params)
    super(context, params)
    @retry_count = 0
  end
end