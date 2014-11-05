#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
class GraphController < ApplicationController
require 'gruff'
require 'code_statistics'

  STATS_DIRECTORIES = [
    %w(Helpers            app/helpers), 
    %w(Controllers        app/controllers), 
    %w(APIs               app/apis),
    %w(Components         components),
    %w(Functional\ tests  test/functional),
    %w(Models             app/models),
    %w(Unit\ tests        test/unit),
    %w(Libraries          lib/),
    %w(Integration\ tests test/integration)
  ].collect { |name, dir| 
      [ name, "#{RAILS_ROOT}/#{dir}" ] 
    }.select { |name, dir| 
      File.directory?(dir) 
    }
  def stats
    code_stats = CodeStatistics.new(*STATS_DIRECTORIES)
    statistics = code_stats.instance_variable_get(:@statistics)
    g = Gruff::Pie.new(500)
    g.font = "/Library/Fonts/Arial"
    g.title = "Code Stats"
    g.theme_37signals
    g.legend_font_size = 10
    0xFDD84E.step(0xFF0000, 1500) do |num|
      g.colors << "#%x"  % num
    end
    statistics.each do |key, values|
      g.data(key, [values["codelines"]])
    end
    send_data(g.to_blob, 
                :disposition => 'inline', 
                :type => 'image/png', 
                :filename => "code_stats.png")
  end
end
