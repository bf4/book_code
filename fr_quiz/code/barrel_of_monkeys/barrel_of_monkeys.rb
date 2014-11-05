#!/usr/local/bin/ruby -w
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


class Song
  def initialize( title, artist, duration )
    @title    = title
    @artist   = artist
    @duration = duration.to_i / 1000
  end
  
  attr_reader :title, :artist, :duration

  def starts_with(  )
    @title[/[A-Za-z0-9]/].downcase
  end

  def ends_with(  )
    @title[/[A-Za-z0-9](?=[^A-Za-z0-9]*$)/].downcase
  end
  
  def ==( other )
    @title == other.title and @artist == other.artist
  end
  
  def to_s(  )
    "#{@title} (by #{@artist} -- #{@duration} seconds)"
  end
end



def build_playlist( start, finish, songs )
  playlists = [[start]]
  
  until playlists.empty? or
        playlists.first.last.ends_with == finish.starts_with
    playlist = playlists.shift
    next unless songs.include? playlist.last.ends_with
    
    songs[playlist.last.ends_with].each do |song|
      next if playlist.find { |s| song.ends_with == s.ends_with }
      playlists << (playlist.dup << song)
    end
  end
  
  if playlist.empty?
    nil
  else
    playlists.shift << finish
  end
end



unless ARGV.size == 2
  puts "Usage:  #{File.basename($0)} START_SONG END_SONG"
  exit
end

warn "Reading song list..."
if File.exist? "song_list.cache"
  songs = File.open("song_list.cache", "r") { |file| Marshal.load(file) }
else
  require "rexml/document"

  songs = Hash.new

  xml = File.open("SongLibrary.xml", "r") { |file| REXML::Document.new(file) }
  xml.elements.each("Library/Artist") do |artist|
    artist.elements.each("Song") do |song|
      name = song.attributes["name"]
      next unless name =~ /[A-Za-z0-9]/
    
      new_song = Song.new( name, artist.attributes["name"],
                                 song.attributes["duration"] )
      songs[new_song.starts_with] ||= Array.new
      songs[new_song.starts_with] << new_song
    end
  end

  File.open("song_list.cache", "w") { |file| Marshal.dump(songs, file) }
end
warn "Song list complete."

start_name, finish_name = ARGV.map { |name| name.downcase }
start = nil
songs.values.each do |song_list|
  start = song_list.find { |song| song.title.downcase.index(start_name) }
  break if start
end
finish = nil
songs.values.each do |song_list|
  finish = song_list.find { |song| song.title.downcase.index(finish_name) }
  break if finish
end
if start.nil?
  puts "Couldn't find #{start_name} in song list."
  exit
end
if finish.nil?
  puts "Couldn't find #{finish_name} in song list."
  exit
end
puts
puts "Start song:  #{start}"
puts "  End song:  #{finish}"
puts



warn "Building playlist..."
playlist = build_playlist(start, finish, songs)
warn "Playlist complete."

puts
if playlist.nil?
  puts "A playlist could not be found, between the selected songs."
else
  puts playlist
end

