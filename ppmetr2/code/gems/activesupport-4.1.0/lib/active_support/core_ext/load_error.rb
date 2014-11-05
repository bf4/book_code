#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class LoadError
  REGEXPS = [
    /^no such file to load -- (.+)$/i,
    /^Missing \w+ (?:file\s*)?([^\s]+.rb)$/i,
    /^Missing API definition file in (.+)$/i,
    /^cannot load such file -- (.+)$/i,
  ]

  unless method_defined?(:path)
    def path
      @path ||= begin
        REGEXPS.find do |regex|
          message =~ regex
        end
        $1
      end
    end
  end

  def is_missing?(location)
    location.sub(/\.rb$/, '') == path.sub(/\.rb$/, '')
  end
end

MissingSourceFile = LoadError