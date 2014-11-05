#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
module ActionDispatch
  module Http
    class UploadedFile
      attr_accessor :original_filename, :content_type, :tempfile, :headers

      def initialize(hash)
        @original_filename = encode_filename(hash[:filename])
        @content_type      = hash[:type]
        @headers           = hash[:head]
        @tempfile          = hash[:tempfile]
        raise(ArgumentError, ':tempfile is required') unless @tempfile
      end

      def open
        @tempfile.open
      end

      def path
        @tempfile.path
      end

      def read(*args)
        @tempfile.read(*args)
      end

      def rewind
        @tempfile.rewind
      end

      def size
        @tempfile.size
      end
      
      private
      def encode_filename(filename)
        # Encode the filename in the utf8 encoding, unless it is nil or we're in 1.8
        if "ruby".encoding_aware? && filename
          filename.force_encoding("UTF-8").encode!
        else
          filename
        end
      end
    end

    module Upload
      # Convert nested Hash to HashWithIndifferentAccess and replace
      # file upload hash with UploadedFile objects
      def normalize_parameters(value)
        if Hash === value && value.has_key?(:tempfile)
          UploadedFile.new(value)
        else
          super
        end
      end
      private :normalize_parameters
    end
  end
end
