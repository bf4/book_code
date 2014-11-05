#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

class Hash

  # find the key with the smallest value, delete it and return it

  def delete_min_value
    return nil if empty?
    minkey=min=nil
    each { |k, v|
      min, minkey=v, k if !min || v<min
    }
    delete(minkey)
    minkey
  end
end



# Maze represents the maze ;-)
#
# Cells/positions in the maze are represented by Numbers (from 0 to
# w*h-1), each position corresponds to x/y coordinates, you can
# convert between positions and coordinates by coord2pos and
# pos2coord.
#
# The walls for each position are stored in the String @data. The
# walls for position p are stored in the first two bits of @data[p],
# and the other bits are unused. If 1 one is set, then p has a north
# wall; if bit 2 is set, then p has a west wall.
#
# Maze#generate generates a (random) maze using the method described
# at http://www.mazeworks.com/mazegen/mazetut/
#
# Maze#shortest_path uses Dijkstra's shortest path algorithm, so it
# can not only find shortest paths in perfect mazes, but also in mazes
# where different paths between two positions exist.

class Maze
  attr_reader :w, :h # width, height

  def initialize(w, h)
    @w, @h=[w, 1].max, [h, 1].max
    @wh=@w*@h
    @neighbors_cache={}
    set_all_walls
  end
end



class Maze
  def set_all_walls
    # set all bits
    @data=3.chr * (@wh)
    nil
  end


  def clear_all_walls
    # all except outer border
    @data=0.chr * (@wh)
    # set north walls of row 0
    w.times { |i| @data[i] |= 1 }
    # set west walls of col 0
    h.times { |i| @data[i*w] |= 2 }
    nil
  end
end



class Maze
  # positions in path will be printed as "X"
  def to_s(path=[])
    ph={}
    path.each { |i| ph[i]=true }
    res=""
    h.times { |y|
      w.times { |x|
        res << "+" << ((@data[y*w+x] & 1 > 0) ? "---" : "   ")
      }
      res << "+\n"
      w.times { |x|
        res << ((@data[y*w+x] & 2 > 0) ? "|" : " ")
        res << (ph[y*w+x] ? " X " : "   ")
      }
      res << "|\n"
    }
    res << ("+---"*w) << "+"
  end

  def inspect
    "#<#{self.class.name} #{w}x#{h}>"
  end
end



class Maze
  # maze positions are cell indices from 0 to w*h-1
  # the following functions do conversions to and from coordinates
  def coord2pos(x, y)
    (y % h) * w + (x % w)
  end
  def pos2coord(p)
    [p % w, (p / w) % h]
  end
end



class Maze
  # returns valid neighbors to p, doesn't care about walls
  def neighbors(p)
    if ce=@neighbors_cache[p]; return ce; end
    res=[p-w, p+w]
    res << p-1 if p%w > 0
    res << p+1 if p%w < w-1
    @neighbors_cache[p] = res.find_all { |t| t>=0 && t<@wh }
  end
end



class Maze
  def wall_between?(p1, p2)
    p1, p2=[p1, p2].sort
    if p2-p1==w # check north wall of p2
      @data[p2] & 1 > 0
    elsif p2-p1==1 # check west wall of p2
      @data[p2] & 2 > 0
    else
      false
    end
  end
  def set_wall(p1, p2)
    p1, p2=[p1, p2].sort
    if p2-p1==w # set north wall of p2
      @data[p2] |= 1
    elsif p2-p1==1 # set west wall of p2
      @data[p2] |= 2
    end
    nil
  end
  def unset_wall(p1, p2)
    p1, p2=[p1, p2].sort
    if p2-p1==w # unset north wall of p2
      @data[p2] &= ~1
    elsif p2-p1==1 # unset west wall of p2
      @data[p2] &= ~2
    end
    nil
  end
end



class Maze
  # generate a (random) perfect maze
  def generate(random=true)
    set_all_walls
    # (random) depth first search method
    visited={0 => true}
    stack=[0]
    until stack.empty?
      n=neighbors(stack.last).reject { |p| visited[p] }
      if n.empty?
        stack.pop
      else
        # choose one unvisited neighbor
        np=n[random ? rand(n.size) : 0]
        unset_wall(stack.last, np)
        visited[np]=true
        # if all neighbors are visited then there is
        # nothing left to do
        stack.pop if n.size==1
        stack.push np
      end
    end
    self
  end
end



class Maze
  # central part of Dijkstra's shortest path algorithm:
  # returns a hash that associates each reachable (from start) position
  # p, with the previous position on the shortest path from start to p
  # and the length of that path.
  # example: if the shortest path from 0 to 2 is [0, 1, 2], then
  # prev[2]==[1, 2], prev[1]==[0, 1] and prev[0]==[nil, 0].
  # so you can get all shortest paths from start to each reachable
  # position out of the returned hash.
  # if stop_at!=nil the method stops when the previous cell on the
  # shortest path from start to stop_at is found.
  def build_prev_hash(start, stop_at=nil)
    prev={start=>[nil, 0]} # hash to be returned
    return prev if stop_at==start
    # positions that we have seen, but we are not yet sure about
    # the shortest path to them (the value is length of the path,
    # for delete_min_value):
    active={start=>0}
    until active.empty?
      # get the position with the shortest path from the
      # active list
      cur=active.delete_min_value
      return prev if cur==stop_at
      newlength=prev[cur][1]+1 # path to cur length + 1
      # for all reachable neighbors of cur, check whether we found
      # a shorter path to them
      neighbors(cur).each { |n|
        # ignore unreachable
        next if wall_between?(cur, n)
        if old=prev[n] # was n already visited
          # if we found a longer path, ignore it
          next if newlength>=old[1]
        end
        # (re)add new position to active list
        active[n]=newlength
        # set new prev and length
        prev[n]=[cur, newlength]
      }
    end
    prev
  end
end



class Maze
  def shortest_path(from, to)
    prev=build_prev_hash(from, to)
    if prev[to]
      # path found, build it by following the prev hash from
      # "to" to "from"
      path=[to]
      path.unshift(to) while to=prev[to][0]
      path
    else
      nil
    end
  end
end



class Maze
  # finds the longest shortest path in this maze, works only if there is
  # at least one position that can reach only one neighbor, because we
  # search only starting at those positions.
  def longest_shortest_path
    startp=endp=nil
    max=-1
    @wh.times { |p|
      # if current p can only reach 1 neighbor
      if neighbors(p).reject { |n| wall_between?(p, n) }.size==1
        prev=build_prev_hash(p)
        # search longest path from p
        tend, tmax=nil, -1
        prev.each { |k, v|
          if v[1]>tmax
            tend=k
            tmax=v[1]
          end
        }
        if tmax>max
          max=tmax
          startp, endp=p, tend
        end
      end
    }
    if startp # path found
      shortest_path(startp, endp)
    else
      nil
    end
  end
end



if $0 == __FILE__
  ARGV.shift if search_longest=ARGV[0]=="-l"
  w, h, from, to=ARGV
  m=Maze.new(w.to_i, h.to_i)
  m.generate
  puts "Maze:", m.to_s
  if from=~/(\d+),(\d+)/
    p1=m.coord2pos($1.to_i, $2.to_i)
  else
    p1=rand(m.w*m.h)
  end
  if to=~/(\d+),(\d+)/
    p2=m.coord2pos($1.to_i, $2.to_i)
  else
    p2=rand(m.w*m.h)
  end

  path=m.shortest_path(p1, p2)
  puts "\nShortest path from #{m.pos2coord(p1).inspect} to " \
  "#{m.pos2coord(p2).inspect}:", m.to_s(path)

  if search_longest
    path=m.longest_shortest_path
    puts "\nLongest shortest path (from " \
    "#{m.pos2coord(path[0]).inspect} to " \
    "#{m.pos2coord(path[-1]).inspect}:",
    m.to_s(path)
  end
end

