#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'div/div'
require 'div/tofusession'
require 'tofu/proxy'

class SumTotal
  def initialize
    @history = []
    @amount = 0
  end
  attr_reader :history, :amount

  def add(value)
    f = value.to_f
    @history.push(f)
    @amount += f
  end

  def undo
    tail = @history.pop
    return unless tail
    @amount -= tail
  end
end

class SumDiv < Div::Div
  set_erb('sum1.erb')

  def initialize(session)
    super(session)
    @model = SumTotal.new
  end

  def do_add(context, params)
    value, = params['value']
    @model.add(value)
  end

  def do_reset(context, params)
    @model = SumTotal.new
  end

  def do_undo(context, params)
    @model.undo
  end
end

class BaseDiv < Div::Div
  set_erb('base1.erb')

  def initialize(session)
    super(session)
    @contents = []
    @contents.push(SumDiv.new(session))
  end
end

class YourTofuSession < Div::TofuSession
  def initialize(bartender, hint=nil)
    super(bartender, hint)
    @base = BaseDiv.new(self)
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
