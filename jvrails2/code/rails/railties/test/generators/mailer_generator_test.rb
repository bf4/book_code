#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "generators/generators_test_helper"
require "rails/generators/mailer/mailer_generator"

class MailerGeneratorTest < Rails::Generators::TestCase
  arguments %w(notifier foo bar)

  def test_mailer_skeleton_is_created
    run_generator
    assert_file "app/mailers/notifier.rb" do |mailer|
      assert_match(/class Notifier < ActionMailer::Base/, mailer)
      assert_match(/default from: "from@example.com"/, mailer)
    end
  end

  def test_mailer_with_i18n_helper
    run_generator
    assert_file "app/mailers/notifier.rb" do |mailer|
      assert_match(/en\.notifier\.foo\.subject/, mailer)
      assert_match(/en\.notifier\.bar\.subject/, mailer)
    end
  end

  def test_invokes_default_test_framework
    run_generator
    assert_file "test/mailers/notifier_test.rb" do |test|
      assert_match(/class NotifierTest < ActionMailer::TestCase/, test)
      assert_match(/test "foo"/, test)
      assert_match(/test "bar"/, test)
    end
  end
end
