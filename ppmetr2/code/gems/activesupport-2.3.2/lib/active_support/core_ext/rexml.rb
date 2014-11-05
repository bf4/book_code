#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# Fixes the rexml vulnerability disclosed at:
# http://www.ruby-lang.org/en/news/2008/08/23/dos-vulnerability-in-rexml/
# This fix is identical to rexml-expansion-fix version 1.0.1
require 'rexml/rexml'

# Earlier versions of rexml defined REXML::Version, newer ones REXML::VERSION
unless (defined?(REXML::VERSION) ? REXML::VERSION : REXML::Version) > "3.1.7.2"
  require 'rexml/document'

  # REXML in 1.8.7 has the patch but didn't update Version from 3.1.7.2.
  unless REXML::Document.respond_to?(:entity_expansion_limit=)
    require 'rexml/entity'

    module REXML
      class Entity < Child
        undef_method :unnormalized
        def unnormalized
          document.record_entity_expansion! if document
          v = value()
          return nil if v.nil?
          @unnormalized = Text::unnormalize(v, parent)
          @unnormalized
        end
      end
      class Document < Element
        @@entity_expansion_limit = 10_000
        def self.entity_expansion_limit= val
          @@entity_expansion_limit = val
        end

        def record_entity_expansion!
          @number_of_expansions ||= 0
          @number_of_expansions += 1
          if @number_of_expansions > @@entity_expansion_limit
            raise "Number of entity expansions exceeded, processing aborted."
          end
        end
      end
    end
  end
end
