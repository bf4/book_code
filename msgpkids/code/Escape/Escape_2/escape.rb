#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---

require 'gosu'
require 'chipmunk'
require_relative 'gosu_camera'
require_relative 'boulder'
require_relative 'platform'
require_relative 'wall'
require_relative 'chip'
require_relative 'moving_platform'

class Escape < Gosu::Window
	attr_reader :space, :camera
	def initialize
		super 800,800,false
    self.caption = "Escape"
    @camera = Gosu::Camera.new(1600,800,1600,800)
    @space = CP::Space.new
    @player = Chip.new(self,70,1500)
    @camera.center_on(@player,400,200)
    @game_over = false
    @background = Gosu::Image.new(self, "images/background.png", false)
    @space.damping = 0.90;
    @space.gravity = CP::Vec2.new(0.0, 100.0)
    @boulders = []
    @platforms = make_platforms
    @floor = Wall.new(self, 800,1610,1600,20)
    @left = Wall.new(self,-10, 800,20,1600)
    @right = Wall.new(self, 1610,870,20,1460)
    @player = Chip.new(self,70,1500)
    @sign = Gosu::Image.new(self, "images/exit.png", false)
    @font = Gosu::Font.new(self, "system", 40)
    @music = Gosu::Song.new("sounds/zanzibar.ogg")
    @music.play(true)
    @quake_time = 0
    @quake_sound = Gosu::Sample.new("sounds/quake.ogg")
  end
  def draw
    @background.draw_with_camera(0,0,0,@camera)
    @background.draw_with_camera(799,0,0,@camera)
    @background.draw_with_camera(0,529,0,@camera)
    @background.draw_with_camera(799,529,0,@camera)
    @background.draw_with_camera(0,1058,0,@camera)
    @background.draw_with_camera(799,1058,0,@camera)
    @background.draw_with_camera(0,1587,0,@camera)
    @background.draw_with_camera(799,1587,0,@camera)

    @sign.draw_with_camera(1450,30,2,@camera)
    @player.draw
    @platforms.each do |platform|
      platform.draw
    end
    @boulders.each do |boulder|
      boulder.draw
    end
    if @game_over == false
      @font.draw("#{@seconds}", 10,20,3,1,1,0xff00ff00)
    else
      @font.draw("#{@win_time/1000}", 10,20,3,1,1,0xff00ff00)
      @font.draw("Game Over",200, 300, 3,2,2,0xff00ff00)
    end
    
  end
  def make_platforms
    #STEP ONE: SQUARE GRID
    platforms = []
    (0..10).each do |row|
      (0..4).each do |column|
        x = column * 300 + 200
        y = row * 140 + 100
        if row % 2 == 0
          x -= 150
        end
        x += rand(100) - 50
        y += rand(100) - 50
        num = rand 
        if num < 0.40
           direction = rand < 0.5 ? :vertical : :horizontal
           range = 30 + rand(40)
           platforms.push MovingPlatform.new(self,x,y,range, direction)
        elsif num < 0.90
           platforms.push Platform.new(self,x,y)
        end
      end
    end
    platforms.push Platform.new(self,1550,140)
    return platforms
  end


  def update
    @camera.center_on(@player,400,200)
    if @game_over == false
      @seconds = (Gosu.milliseconds / 1000).to_i
      10.times do 
        @space.step(1.0/300)
      end
      boulder_chance = @quake_time > 0 ? 0.2 : 0.01
      if rand < boulder_chance  
        @boulders.push Boulder.new(self,200 + rand(1200),-20)
      end
      if @player.x > 1620
        @game_over = true
        @win_time = Gosu.milliseconds
      end
      @player.check_footing(@platforms + @boulders)
    
      @platforms.each do |platform|
        platform.move
      end
      if button_down?(Gosu::KbRight)
    	  @player.move_right
      elsif button_down?(Gosu::KbLeft)
        @player.move_left
      else
        @player.stand
      end
      if rand < 0.001
        quake
      end
      @quake_time -= 1
      if @quake_time > 0
        @camera.shake
      end
    end

  end
  def quake
    @quake_time = 30
    @quake_sound.play
    @boulders.each do |boulder|
      boulder.quake
    end
  end
  def button_down(id)
    if id == Gosu::KbSpace
      @player.jump
    end
    if id == Gosu::KbQ
      exit
    end
  end
end

window = Escape.new
window.show