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

require 'countlogin'

class SimpleLogin < Div::Login
  def initialize
    super
    @db = {'foo' => 'foo00', 'bar' => 'bar00'}
  end

  def get_user(user, pass)
    return nil if user.nil? || pass.nil?
    return nil unless @db[user] == pass
    user
  end
end

class BaseDiv < Div::Div
  set_erb('login_base.erb')

  def initialize(session)
    super(session)
    @contents = []
    @contents.push(CountLoginDiv.new(session, session.login, session.hint))
  end
end

class YourTofuSession < Div::TofuSession
  def initialize(bartender, hint=nil)
    super(bartender, hint)
    @login = SimpleLogin.new
    @base = BaseDiv.new(self)
  end
  attr_reader :login

  def hint
    if @login.login? && !@login.guest?
      @login.name
    else
      super
    end
  end

  def do_GET(context)
    update_div(context)
    context.res_header('content-type', 'text/html; charset=euc-jp')
    context.res_body(@base.to_html(context))
  end
end

if __FILE__ == $0
  tofu = Tofu::Bartender.new(YourTofuSession)
  DRb.start_service('druby://localhost:12345', tofu)
  DRb.thread.join
end