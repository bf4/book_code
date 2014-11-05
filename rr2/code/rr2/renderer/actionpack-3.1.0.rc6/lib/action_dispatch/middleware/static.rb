#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require 'rack/utils'

module ActionDispatch
  class FileHandler
    def initialize(root, cache_control)
      @root          = root.chomp('/')
      @compiled_root = /^#{Regexp.escape(root)}/
      @file_server   = ::Rack::File.new(@root, cache_control)
    end

    def match?(path)
      path = path.dup

      full_path = path.empty? ? @root : File.join(@root, ::Rack::Utils.unescape(path))
      paths = "#{full_path}#{ext}"

      matches = Dir[paths]
      match = matches.detect { |m| File.file?(m) }
      if match
        match.sub!(@compiled_root, '')
        match
      end
    end

    def call(env)
      @file_server.call(env)
    end

    def ext
      @ext ||= begin
        ext = ::ActionController::Base.page_cache_extension
        "{,#{ext},/index#{ext}}"
      end
    end
  end

  class Static
    def initialize(app, path, cache_control=nil)
      @app = app
      @file_handler = FileHandler.new(path, cache_control)
    end

    def call(env)
      case env['REQUEST_METHOD']
      when 'GET', 'HEAD'
        path = env['PATH_INFO'].chomp('/')
        if match = @file_handler.match?(path)
          env["PATH_INFO"] = match
          return @file_handler.call(env)
        end
      end

      @app.call(env)
    end
  end
end
