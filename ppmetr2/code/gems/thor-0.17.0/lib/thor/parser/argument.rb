#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Thor
  class Argument #:nodoc:
    VALID_TYPES = [ :numeric, :hash, :array, :string ]

    attr_reader :name, :description, :enum, :required, :type, :default, :banner
    alias :human_name :name

    def initialize(name, options={})
      class_name = self.class.name.split("::").last

      type = options[:type]

      raise ArgumentError, "#{class_name} name can't be nil."                         if name.nil?
      raise ArgumentError, "Type :#{type} is not valid for #{class_name.downcase}s."  if type && !valid_type?(type)

      @name        = name.to_s
      @description = options[:desc]
      @required    = options.key?(:required) ? options[:required] : true
      @type        = (type || :string).to_sym
      @default     = options[:default]
      @banner      = options[:banner] || default_banner
      @enum        = options[:enum]

      validate! # Trigger specific validations
    end

    def usage
      required? ? banner : "[#{banner}]"
    end

    def required?
      required
    end

    def show_default?
      case default
      when Array, String, Hash
        !default.empty?
      else
        default
      end
    end

    protected

      def validate!
        if required? && !default.nil?
          raise ArgumentError, "An argument cannot be required and have default value."
        elsif @enum && !@enum.is_a?(Array)
          raise ArgumentError, "An argument cannot have an enum other than an array."
        end
      end

      def valid_type?(type)
        self.class::VALID_TYPES.include?(type.to_sym)
      end

      def default_banner
        case type
        when :boolean
          nil
        when :string, :default
          human_name.upcase
        when :numeric
          "N"
        when :hash
          "key:value"
        when :array
          "one two three"
        end
      end

  end
end
