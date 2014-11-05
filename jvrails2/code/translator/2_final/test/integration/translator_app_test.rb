#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
require "test_helper"

class TranslatorAppTest < ActiveSupport::IntegrationCase
  # Set up store and load default translations
  setup { Translator.reload! }

  setup { sign_in(admin) }

  def admin
    @admin ||= Admin.create!(
      email: "admin_#{Admin.count}@example.org",
      password: "12345678"
    )
  end

  def sign_in(admin)
    visit "/admins/sign_in"
    fill_in "Email",    with: admin.email
    fill_in "Password", with: admin.password
    click_button "Sign in"
  end

  test "can translate messages from a given locale to another" do
    assert_raise I18n::MissingTranslationData do
      I18n.l(Date.new(2010, 4, 17), locale: :pl)
    end

    visit "/translator/en/pl"
    fill_in "date.formats.default", with: %{"%d-%m-%Y"}
    click_button "Store translations"

    assert_match "Translations stored with success!", page.body
    assert_equal "17-04-2010", I18n.l(Date.new(2010, 4, 17), locale: :pl)
  end
end