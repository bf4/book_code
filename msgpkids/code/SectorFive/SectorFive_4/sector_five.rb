#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
#SectorFive_3
require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'
class GameWindow < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.05
  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "Sector Five"
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
  end
  def update
    if button_down?(Gosu::KbLeft)
      @player.turn_left
    end
    if button_down?(Gosu::KbRight)
      @player.turn_right
    end
    if button_down?(Gosu::KbUp)
      @player.accelerate
    end
    @player.move
    if rand < ENEMY_FREQUENCY
      @enemies.push Enemy.new(self)
    end
    @enemies.each do |enemy|
      enemy.move
    end
    @enemies.dup.each do |enemy|
      @enemies.delete enemy if enemy.y > HEIGHT +  enemy.radius
    end
    @bullets.each do |bullet|
      bullet.move
    end
    @bullets.dup.each do |bullet|
      @bullets.delete bullet if not bullet.onscreen?
    end
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        if distance < enemy.radius + bullet.radius
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push Explosion.new(self, enemy.x, enemy.y)
            
        end
      end
    end 
    @explosions.dup.each do |explosion|
      @explosions.delete explosion if explosion.finished
    end
  end
  def button_down(id)
      if id == Gosu::KbSpace
        @bullets.push Bullet.new(self,  @player.x, @player.y, @player.angle)
      end
  end
  def draw
    @player.draw
    @enemies.each do |enemy|
      enemy.draw
    end
    @bullets.each do |bullet|
      bullet.draw
    end
    @explosions.each do |explosion|
      explosion.draw
    end
  end

end

window = GameWindow.new
window.show