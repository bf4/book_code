#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

class GED2XML

  IS_ID = /^@.*@$/

  class Node < Struct.new( :level, :tag, :data, :refid )
    def initialize( line=nil )
      level, tag, data = line.chomp.split( /\s+/, 3 )
      level = level.to_i
      tag, refid, data = data, tag, nil if tag =~ IS_ID
      super level, tag.downcase, data, refid
    end
  end

  def indent( level )
    print "  " * ( level + 1 )
  end

  def safe( text )
    text.
      gsub( /&/, "&amp;" ).
      gsub( /</, "&lt;" ).
      gsub( />/, "&gt;" ).
      gsub( /"/, "&quot;" )
  end

  def process( io )
    node_stack = []

    puts "<gedcom>"
    wrote_newline = true

    io.each_line do |line|
      next if line =~ /^\s*$/o
      node = Node.new( line )

      while !node_stack.empty? && node_stack.last.level >= node.level
        prev = node_stack.pop
        indent prev.level if wrote_newline
        print "</#{prev.tag}>\n"
        wrote_newline = true
      end

      indent node.level if wrote_newline
      print "<#{node.tag}"
      print " id=\"#{node.refid}\"" if node.refid

      if node.data
        if node.data =~ IS_ID
          print " ref=\"#{node.data}\">"
        else
          print ">#{safe(node.data)}"
        end
        wrote_newline = false
      else
        puts ">"
        wrote_newline = true
      end

      node_stack << node
    end

    until node_stack.empty?
      prev = node_stack.pop
      indent prev.level if wrote_newline
      print "</#{prev.tag}>\n"
      wrote_newline = true
    end

    puts "</gedcom>"
  end

end

GED2XML.new.process ARGF
