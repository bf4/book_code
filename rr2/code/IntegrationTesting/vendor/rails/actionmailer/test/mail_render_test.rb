#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
$:.unshift(File.dirname(__FILE__) + "/../lib/")

require 'test/unit'
require 'action_mailer'

class RenderMailer < ActionMailer::Base
  def inline_template(recipient)
    recipients recipient
    subject    "using helpers"
    from       "tester@example.com"
    body       render(:inline => "Hello, <%= @world %>", :body => { :world => "Earth" })
  end

  def file_template(recipient)
    recipients recipient
    subject    "using helpers"
    from       "tester@example.com"
    body       render(:file => "signed_up", :body => { :recipient => recipient })
  end

  def initialize_defaults(method_name)
    super
    mailer_name "test_mailer"
  end
end

RenderMailer.template_root = File.dirname(__FILE__) + "/fixtures"

class RenderHelperTest < Test::Unit::TestCase
  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    ActionMailer::Base.deliveries = []

    @recipient = 'test@localhost'
  end

  def test_inline_template
    mail = RenderMailer.create_inline_template(@recipient)
    assert_equal "Hello, Earth", mail.body.strip
  end

  def test_file_template
    mail = RenderMailer.create_file_template(@recipient)
    assert_equal "Hello there, \n\nMr. test@localhost", mail.body.strip
  end
end

