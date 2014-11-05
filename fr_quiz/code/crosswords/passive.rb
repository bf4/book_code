#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
module CrossWord
  
  CELL_WIDTH = 6
  CELL_HEIGHT = 4
  
  def self.build( str )
    Board.new( str ).build
  end
  
  class Board
    def initialize( layout )
      b = layout.upcase  # upcase and duplicate input layout
      lines = b.split(/\n/)  # split into array of lines
      # split line into array of tokens...
      @board = lines.collect{ |line| line.scan(/[_X]/) }
      @cnt=0  # set cell counter (for numbering)
    end
  
    def height ; @height ||= @board.length ; end
    def width ; @width ||= @board[0].length ; end
    
    # the board builds itself as it is called upon
    def board(y,x)
      return nil if @board[y][x] == 'P' # pending resolution
      # resolution complete...
      return @board[y][x] if @board[y][x] != '_' and @board[y][x] != 'X'
      return @board[y][x] = 'u' if @board[y][x] == '_'
      # on edge...
      return @board[y][x] = 'e' if y==0 or x==0 or y==height-1 or x==width-1
      if @board[y][x] == 'X'  # could be edge or solid
        @board[y][x] = 'P' # mark as pending (prevents infinite recursion)
        return @board[y][x] = 'e' if  # edge if neighbor is edge
          board(y-1,x) == 'e' or board(y,x+1) == 'e' or
          board(y+1,x) == 'e' or board(y,x-1) == 'e'
      end
      return @board[y][x] = 's'  # else solid
    end
    
    # build the puzzle
    def build
      puzzle = Puzzle.new( height, width ) # new puzzle
      # edges must be done first since they clear spaces
      @board.each_with_index{ |line,y|
        line.each_index{ |x|
          type = board(y,x)
          puzzle.push(type,y,x,nil) if type == 'e'
        }
      }
      # build-up all the solid and filled-in pieces
      @board.each_with_index{ |line,y|
        line.each_index{ |x|
          type = board(y,x)
          cnt = upper_left?(type,y,x) ? (@cnt += 1) : ''
          puzzle.push(type,y,x,cnt) if type != 'e'
      } }
      puzzle.to_s  # return the final product
    end
    
    # determines whether a cell should be numbered
    def upper_left?(type,y,x)
      return false if type != 'u'
      return true if y == 0 and board(y+1,x) == 'u'
      return true if x == 0 and board(y,x+1) == 'u'
      if x != width-1 and board(y,x+1) == 'u'
        return true if board(y,x-1) == 'e'
        return true if board(y,x-1) == 's'
      end
      if y != height-1 and board(y+1,x) == 'u'
        return true if board(y-1,x) == 'e' 
        return true if board(y-1,x) == 's'
      end
      return false
    end
  
  end
  
  # Puzzle is a simple matrix
  class Puzzle
    attr_reader :puzzle
    def initialize(height, width)
      @puzzle = ['']  # build a blank to work on
      (height*(CELL_HEIGHT-1)+1).times{ |y|
        (width*(CELL_WIDTH-1)+1).times{ |x| @puzzle.last << '.' }
        @puzzle << ''
      }
    end
    def push(type,y,x,cnt)
      c = space(type,cnt)
      ny = y * (CELL_HEIGHT - 1)
      nx = x * (CELL_WIDTH - 1)
      @puzzle[ny+0][nx,CELL_WIDTH] = c[0]
      @puzzle[ny+1][nx,CELL_WIDTH] = c[1]
      @puzzle[ny+2][nx,CELL_WIDTH] = c[2]
      @puzzle[ny+3][nx,CELL_WIDTH] = c[3]
    end
    def space(type,cnt)
      case type
      when "u"
        [ "######",
          "#%-4s#" % cnt,
          "#    #",
          "######" ]
      when "s"
        [ "######" ] * 4
      when "e"
        [ "      " ] * 4
      end    
    end
    def to_s ; @puzzle.join("\n") ; end
  end

end

if $0 == __FILE__
  $stdout << CrossWord.build( gets(nil) )
end
