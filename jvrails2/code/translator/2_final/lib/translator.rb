#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
module Translator
  DATABASES = {
    "development" => 0,
    "test" => 1,
    "production" => 2
  }

  def self.store
    @store ||= Redis.new(db: DATABASES[Rails.env.to_s])
  end

  class Backend < I18n::Backend::KeyValue 
    include I18n::Backend::Memoize

    def initialize
      super(Translator.store)
    end
  end
end

module Translator
  autoload :App, "translator/app"

  def self.reload!
    store.flushdb
    I18n.backend.load_translations
  end
end