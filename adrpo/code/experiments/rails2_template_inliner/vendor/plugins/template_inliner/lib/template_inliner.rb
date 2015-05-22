#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
# Copyright (c) 2008-2009 Pluron, Inc.

module ActionView

    class Base
        # Specify whether templates should be inlined.
        # Inlining is turned off by default.
        @@inline_templates = false
        cattr_accessor :inline_templates
    end

    class Template

        alias_method :old_initialize, :initialize
        def initialize(template_path, load_path)
            @view_storage = {:view => nil}
            old_initialize(template_path, load_path)
        end

        attr_accessor :view_storage

        def source
            if ActionView::Base.inline_templates
                read_template_source(filename)
            else
                File.read(filename)
            end
        end

    private
        def read_template_source(template_path)
            contents = ""
            File.read(template_path).each_line do |line|
                if line =~ /^(.*)<%=\s*render\s+:partial\s*=>\s*['"](.*)['"].*:inline\s*=>\strue\s*-?%>(.*)$/ and view_storage[:view]
                    template = view_storage[:view].send(:_pick_partial_template, $2)
                    contents << $1
                    contents << template.source
                    contents << $3
                else
                    contents << line
                end
            end
            contents
        end
    end
end


module ActionView
    module Partials
    private

        def _pick_partial_template_with_view_setting(partial_path)
            template = _pick_partial_template_without_view_setting(partial_path)
            template.view_storage[:view] = self
            template
        end
        alias_method_chain :_pick_partial_template, :view_setting

    end
end
