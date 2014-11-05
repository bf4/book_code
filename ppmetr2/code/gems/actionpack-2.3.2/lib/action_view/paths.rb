#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActionView #:nodoc:
  class PathSet < Array #:nodoc:
    def self.type_cast(obj)
      if obj.is_a?(String)
        if Base.cache_template_loading?
          Template::EagerPath.new(obj.to_s)
        else
          ReloadableTemplate::ReloadablePath.new(obj.to_s)
        end
      else
        obj
      end
    end
    
    def initialize(*args)
      super(*args).map! { |obj| self.class.type_cast(obj) }
    end

    def <<(obj)
      super(self.class.type_cast(obj))
    end

    def concat(array)
      super(array.map! { |obj| self.class.type_cast(obj) })
    end

    def insert(index, obj)
      super(index, self.class.type_cast(obj))
    end

    def push(*objs)
      super(*objs.map { |obj| self.class.type_cast(obj) })
    end

    def unshift(*objs)
      super(*objs.map { |obj| self.class.type_cast(obj) })
    end
    
    def load!
      each(&:load!)
    end

    def find_template(original_template_path, format = nil, html_fallback = true)
      return original_template_path if original_template_path.respond_to?(:render)
      template_path = original_template_path.sub(/^\//, '')

      each do |load_path|
        if format && (template = load_path["#{template_path}.#{I18n.locale}.#{format}"])
          return template
        elsif format && (template = load_path["#{template_path}.#{format}"])
          return template
        elsif template = load_path["#{template_path}.#{I18n.locale}"]
          return template
        elsif template = load_path[template_path]
          return template
        # Try to find html version if the format is javascript
        elsif format == :js && html_fallback && template = load_path["#{template_path}.#{I18n.locale}.html"]
          return template
        elsif format == :js && html_fallback && template = load_path["#{template_path}.html"]
          return template
        end
      end

      return Template.new(original_template_path, original_template_path =~ /\A\// ? "" : ".") if File.file?(original_template_path)

      raise MissingTemplate.new(self, original_template_path, format)
    end
  end
end
