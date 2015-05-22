#---
# Excerpted from "Text Processing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rmtpruby for more book information.
#---
require "open-uri"
require "nokogiri"

class LeagueTable
  def initialize(url = "http://www.bbc.co.uk/sport/football/premier-league/table")
    @url = url
    parse(html)
  end

  def html
    @html ||= open(@url)
  end

  def parse(html)
    @doc ||= Nokogiri::HTML(html)
  end

  def teams
    @teams ||= rows.map { |row| Team.from_html(row) }
  end

  def each(*args, &block)
    teams.each(&block)
  end
  include Enumerable

  private
  def rows
    @doc.at_css('table.table-stats').css('tbody tr')
  end

end

class Team < Struct.new(:position, :name, :points)
  def self.from_html(row)
    new(
      row.at_css('span.position-number').text.to_i,
      row.at_css('td.team-name').text,
      row.at_css('td.points').text.to_i
    )
  end
end

table = LeagueTable.new
table.each do |team|
  printf "%2s. %-14s %3d pts\n", team.position, team.name, team.points
end
