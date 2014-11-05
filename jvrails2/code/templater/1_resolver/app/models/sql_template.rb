#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
class SqlTemplate < ActiveRecord::Base
  validates :body, :path, presence: true
  validates :format,  inclusion: Mime::SET.symbols.map(&:to_s)
  validates :locale,  inclusion: I18n.available_locales.map(&:to_s)
  validates :handler, inclusion:
    ActionView::Template::Handlers.extensions.map(&:to_s)

  class Resolver < ActionView::Resolver
    protected

    def find_templates(name, prefix, partial, details)
      conditions = {
        path: normalize_path(name, prefix),
        locale: normalize_array(details[:locale]).first,
        format: normalize_array(details[:formats]).first,
        handler: normalize_array(details[:handlers]),
        partial: partial || false
      }
      ::SqlTemplate.where(conditions).map do |record|
        initialize_template(record)
      end
    end
    # Normalize name and prefix, so the tuple ["index", "users"] becomes
    # "users/index" and the tuple ["template", nil] becomes "template".
    def normalize_path(name, prefix)
      prefix.present? ? "#{prefix}/#{name}" : name
    end
    # Normalize arrays by converting all symbols to strings.
    def normalize_array(array)
      array.map(&:to_s)
    end
    # Initialize an ActionView::Template object based on the record found.
    def initialize_template(record)
      source = record.body
      identifier = "SqlTemplate - #{record.id} - #{record.path.inspect}"
      handler = ActionView::Template.registered_template_handler(record.handler)

      details = {
        format: Mime[record.format],
        updated_at: record.updated_at,
        virtual_path: virtual_path(record.path, record.partial)
      }
      ActionView::Template.new(source, identifier, handler, details)
    end

    # Make paths as "users/user" become "users/_user" for partials.
    def virtual_path(path, partial)
      return path unless partial
      if index = path.rindex("/")
        path.insert(index + 1, "_")
      else
        "_#{path}"
      end
    end
  end
end
