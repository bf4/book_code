#!/usr/local/bin/ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

#
# Barrel of Monkeys playlist search tool
#
# A response to Ruby Quiz of the Week #30 - Barrel of Monkeys [ruby-talk:140425]
#
# Prompts the user interactively for criteria, and searches its database of
# songs and returns playlists with each song's first letter matching the
# previous song's last letter.
#
# The user-entered criteria include first letter, last letter, bounds and
# targets for number of songs and duration, and excluded songs.
#
# Author: Dave Burt <dave at burt.id.au>
#
# Created: 30 Apr 2005
#
# Last modified: 2 May 2005
#
# Fine print: Provided as is. Use at your own risk. Unauthorized copying is
#             not disallowed. Credit's appreciated if you use my code. I'd
#             appreciate seeing any modifications you make to it.
#


#
# A Song has a name, an artist, a duration, and an optional id
#
class Song
  def initialize(name, artist, duration = nil, id = 0)
    @name = name
    @artist = artist
    @duration = duration
    @id = id
  end
  attr_accessor :name, :artist, :duration, :id
  def basic_name
    @name.gsub(/\s*([\[(]).*\1\s*$/, '').gsub(/\bfeat.*$/, '')
  end
  def to_s
    "#@artist - #@name (#{@duration.min_sec})"
  end
  def inspect
    to_s
  end
  
  # and, for the barrels of monkeys:
  
  def first_letter
    m = basic_name.match(/([a-z])/i)
    m[1].downcase if m
  end
  def last_letter
    m = basic_name.match(/([a-z])[^a-z]*$/i)
    m[1].downcase if m
  end
end



class Integer
  #
  # Display a time in milliseconds as m:ss
  #
  def min_sec
    "#{self/60000}:%02d" % (self/1000 % 60)
  end
  
  #
  # Display a time in milliseconds as h:mm:ss
  #
  def hr_min_sec
    "#{self/3600000}:%02d:%02d" % [self/60000 % 60, self/1000 % 60]
  end
end

class Array
  #
  # Return the sum of the durations of the elements
  #
  def total_duration
    inject(0) {|memo, song| memo + song.duration }
  end
  
  #
  # Return a string listing the contents of this array as a playlist, with
  # an appropriate header
  #
  def playlist_string
    i = 0
    "<Playlist tracks: #{size}, duration: #{total_duration.hr_min_sec}>\n" +
    map {|song| " #{i += 1}. #{song}\n" }.join
  end
end



#
# A barrel of monkeys seems to be a set of songs with the capability to
# return playlists whose successive songs match last to first letter.
#
class BarrelOfMonkeys
  def initialize(songs)
    @songs = songs
  end
  attr_accessor :songs
  
  #
  # Index songs by first letter
  #
  def build_index
    @songs_by_first_letter = {}
    @songs.each do |song|
      (@songs_by_first_letter[song.first_letter] ||= []) << song \
        if song.first_letter
    end
    self
  end
  
  #
  # Searches @songs for barrel of monkeys playlists that match the given
  # criteria. The first letter in the title of each successive song in
  # each playlist is always the same as the last letter in the prior song.
  # 
  # These are the allowed criteria (all are optional):
  #   first_letter     Playlists' first songs must begin with this letter
  #   last_letter      Playlists' last songs must end with this letter
  #   min_songs        Playlists must have at least this many songs
  #   max_songs        Playlists may have no more than this many songs
  #   target_songs     Only return playlists with as close as possible to
  #                    this number of songs
  #   min_duration     Playlists must run at least this many milliseconds
  #   max_duration     Playlists must run for no more milliseconds than this
  #   target_duration  Only return playlists with as close as possible to
  #                    this duration in milliseconds
  #   exclude_songs    Playlists must not include any songs included here
  #
  def playlists(criteria = {})
    first_letter = criteria[:first_letter].downcase rescue nil
    last_letter = criteria[:last_letter].downcase rescue nil
    min_songs = criteria[:min_songs] || 1
    max_songs = criteria[:max_songs] || 1.0 / 0.0
    target_songs = criteria[:target_songs]
    min_duration = criteria[:min_duration] || 0
    max_duration = criteria[:max_duration] || 1.0 / 0.0
    target_duration = criteria[:target_duration]
    exclude_songs = criteria[:exclude_songs] || []
    
    build_index unless @songs_by_first_letter
    
    # build list of songs starting with required first letter
    result = (@songs_by_first_letter[first_letter] || @songs).map do |song|
      [song] unless exclude_songs.include? song
    end.
    delete_if {|song| song.nil? }
    
    # to each of those, add playlists starting with their last letter
    # (recursively, depth-first(!))
    if max_songs > 1
      result.map do |playlist|
        playlist_duration = playlist.total_duration
        playlists(
          :first_letter => playlist[-1].last_letter,
          :last_letter => last_letter,
          :min_songs => [min_songs - 1, 0].max,
          :max_songs => max_songs - 1,
          :target_songs => target_songs && target_songs - 1,
          :min_duration => min_duration - playlist_duration,
          :max_duration => max_duration - playlist_duration,
          :target_duration => target_duration &&
                              target_duration - playlist_duration,
          :exclude_songs => exclude_songs | playlist
        ).map do |subplaylist|
          playlist + subplaylist if subplaylist
        end
      end.each do |playlist|
        result.concat(playlist.to_a)
      end
    end
    
    # remove all playlists with the wrong last letter
    if last_letter
      result.delete_if {|pl| pl.last.last_letter != last_letter }
    end
    
    # remove all playlists with too few songs or too short or too long a
    # duration
    result.delete_if do |pl|
      pl.size < min_songs or
      not pl.total_duration.between?(min_duration, max_duration)
    end
    
    # if a specific duration was requested, find the closest
    if target_duration
      closest_duration = result.inject(1.0/0.0) do |memo, pl|
        [ memo, (pl.total_duration - target_duration).abs ].min
      end
      result.delete_if do |pl|
        (pl.total_duration - target_duration).abs != closest_duration
      end
    end
    
    # if a specific number of songs were requested, find the closest
    if target_songs
      closest_songs = result.inject(1.0/0.0) do |memo, pl|
        [ memo, (pl.size - target_songs).abs ].min
      end
      result.delete_if do |playlist|
        (playlist.size - target_songs).abs != closest_songs
      end
    end
    
    result
  end
end



if $0 == __FILE__
  
  print "Loading..."

  # HighLine::Dave
  # http://www.dave.burt.id.au/ruby/highline/dave.rb
  require 'highline/dave'
  require 'yaml'
  SONG_LIST = YAML.load_file("SongLibrary.yaml")
  
  barrel_of_monkeys = BarrelOfMonkeys.new(SONG_LIST)
  barrel_of_monkeys.build_index
  
  puts "done."
  
  begin
  
    t = Time.now
    
    criteria = {
      :first_letter => ask(
        "What letter should the first song start with?", /^[a-z]$/i),
      :last_letter => ask(
        "What letter should the last song end with?", /^[a-z]$/i),
      :min_songs => ask(
        "Minimum songs in playlist:", 1),
      :max_songs => ask(
        "Maximum songs in playlist (more than 3 could take a while):",
        SONG_LIST.size),
      :target_songs => ask(
        "Target number of songs: [no target]",
        Integer, :default => false, :display_default => false),
      :min_duration => ask(
        "Minimum duration in milliseconds:", 0),
      :max_duration => ask(
        "Maximum duration in milliseconds:", Integer, 1.0/0.0),
      :target_duration => ask(
        "Target duration in milliseconds: [no target]",
        Integer, :default => false, :display_default => false),
    }
    print "Generating playlists..."
    
    playlists = barrel_of_monkeys.playlists(criteria)
    
    puts "done in #{Time.now - t} seconds."
    puts "Found #{playlists.size} playlist#{'s' unless playlists.size == 1}:"
    puts playlists.map{|pl| pl.playlist_string }
    
  end while ask("Another barrel of monkeys?", FalseClass)
end

