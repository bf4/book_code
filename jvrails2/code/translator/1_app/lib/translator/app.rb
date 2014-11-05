#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module Translator
  class App < Sinatra::Base
    set :environment, Rails.env
    enable :inline_templates

    get "/:from/:to" do |from, to|
      exhibit_translations(from, to)
    end

    protected

    # Store from and to locales in variables and retrieve
    # all keys available for translation.
    def exhibit_translations(from, to)
      @from, @to, @keys = from, to, available_keys(from)
      haml :index
    end

    # Get all keys for a locale. Remove the locale from the key and sort them.
    # If a key is named "en.foo.bar", this method will return it as "foo.bar".
    def available_keys(locale)
      keys  = Translator.store.keys("#{locale}.*")
      range = Range.new(locale.size + 1, -1)
      keys.map { |k| k.slice(range) }.sort!
    end

    # Get the value in the translator store for a given locale. This method
    # decodes values and checks if they are a hash, as we don't want subtrees
    # available for translation since they are managed automatically by I18n.
    def locale_value(locale, key)
      value = Translator.store["#{locale}.#{key}"]
      value if value && !ActiveSupport::JSON.decode(value).is_a?(Hash)
    end
  end
end
__END__

@@ index
!!!
%html
  %head
    %title
      Translator::App
  %body
    %h2= "From #{@from} to #{@to}"

    %p(style="color:green")= @message

    - if @keys.empty?
      No translations available for #{@from}
    - else
      %form(method="post" action="")
        - @keys.each do |key|
          - from_value = locale_value(@from, key)
          - next unless from_value
          - to_value = locale_value(@to, key) || from_value
          %p
            %label(for=key)
              %small= key
              = from_value
            %br
            %input(id=key name=key type="text" value=to_value size="120")
        %p
          %input(type="submit" value="Store translations")
