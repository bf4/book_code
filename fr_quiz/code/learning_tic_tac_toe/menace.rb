#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---


require "tictactoe"

class MENACE < TicTacToe::Player
  class Position
    def self.generate_positions( io )
      io << "[\n"
      queue = [self.new]
      queue[-1].save(io)
      
      seen = [queue[-1]]
      while queue.size > 0
        positions = queue.shift.leads_to.
                    reject { |p| p.over? or seen.include?(p) }
        positions.each { |p| p.save(io) } if positions.size > 0 and
                                             positions[0].turn == "X"
        queue.push(*positions)
        seen.push(*positions)
      end
      io << "]\n"
    end
  end
end

    

class MENACE < TicTacToe::Player
  class Position
    def initialize( box   = TicTacToe::Board.new([" "] * 9),
                    beads = (0..8).to_a * 4 )
      @box   = box
      @beads = beads
    end
    
    def leads_to(  )
      @box.moves.inject([ ]) do |all, move|
        m     = TicTacToe::Board.name_to_index(move)
        box   = TicTacToe::Board.new((0..8).
                map { |i| i == m ? turn : @box[i] })
        beads = @beads.reject { |b| b == m }
        if turn == "O"
          i = beads.rindex(beads[0])
          beads = beads[0...i] unless i == 0
        end
        all << self.class.new(box, beads)
      end
    end
    
    def over?(  )
      @box.moves.size == 1 or @box.won?
    end
    
    def save( io )
      box   = @box.to_s.split("").map { |c| %Q{"#{c}"} }.join(", ")
      beads = @beads.inspect
      
      io << "  MENACE::Position.new([#{box}], #{beads}),\n"
    end
    
    def turn(  )
      if @box.xs == @box.os then "X" else "O" end
    end
    
    def box_str(  )
      @box.to_s
    end
    
    def ==( other )
      box_str == other.box_str
    end
  end
end

    

class MENACE < TicTacToe::Player
  class Position
    def learn_win( move )
      return if @beads.size == 1
      2.times { @beads << move }
    end

    def learn_loss( move )
      return if @beads.size == 1
      @beads.delete_at(@beads.index(move))
      @beads.uniq! if @beads.uniq.size == 1
    end

    def choose_move(  )
      @beads[rand(@beads.size)]
    end
  end
end



class MENACE < TicTacToe::Player
  BRAIN_FILE = "brain.rb"
  unless test(?e, BRAIN_FILE)
    File.open(BRAIN_FILE, "w") { |file| Position.generate_positions(file) }
  end
  BRAIN = File.open(BRAIN_FILE, "r") { |file| eval(file.read) }
  
  def initialize( pieces )
    super
    
    @moves = []
  end
  
  def move( board )
    choices = board.moves
    return choices[0] if choices.size == 1
    
    current  = Position.new(board, [ ])
    position = BRAIN.find() { |p| p == current }
    
    move = position.choose_move
    @moves << [position, move]
    TicTacToe::Board.index_to_name(move)
  end
  
  def finish( final_board )
    if final_board.won? == @pieces
      @moves.each { |(pos, move)| pos.learn_win(move) }
    elsif final_board.won? != " "
      @moves.each { |(pos, move)| pos.learn_loss(move) }
    end
  end
end



if __FILE__ == $0
  puts "Training..."
  if ARGV.size == 1 and ARGV[0] =~ /^\d+$/
    ARGV[0].to_i.times do
      game = TicTacToe::Game.new(MENACE, TicTacToe::SmartPlayer, false)
      game.play
    end
  end
  
  play_again = true
  while play_again
    game = TicTacToe::Game.new(MENACE, TicTacToe::HumanPlayer, false)
    game.play
    
    print "Play again?  "
    play_again = $stdin.gets =~ /^y/i
  end
end

