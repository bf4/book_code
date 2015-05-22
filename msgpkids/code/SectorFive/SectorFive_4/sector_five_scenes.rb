#---
# Excerpted from "Learn Game Programming with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/msgpkids for more book information.
#---
require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'
require_relative 'credit'

class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.05
  MAX_ENEMIES = 100
  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "Sector Five"
    @background_image = Gosu::Image.new(self,'images/start_screen.png', false)
    @scene = :start
    @start_music = Gosu::Song.new('sounds/Lost Frontier.ogg')
    @start_music.play(true)
  end
  def update
    case @scene
    when :game
      update_game
    when :end
      update_end
    end
  end
  def update_game
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
      @enemies_appeared += 1
      if @enemies_appeared > MAX_ENEMIES
        initialize_end(:count_reached)
      end
    end
    @enemies.dup.each do |enemy|
      if enemy.y > HEIGHT +  enemy.radius
        @enemies.delete enemy
        @enemies_escaped += 1
      end
    end
    @enemies.each do |enemy|
      enemy.move
    end
    @bullets.each do |bullet|
      bullet.move
    end
    @bullets.dup.each do |bullet|
      distance = Gosu.distance(bullet.x, bullet.y, WIDTH/2, HEIGHT/2)
      @bullets.delete  bullet if distance > WIDTH
    end
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
        if distance < enemy.radius + bullet.radius
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push Explosion.new(self, enemy.x, enemy.y)
          @enemies_destroyed += 1
          @explosion_sound.play
        end
      end
    end
    @enemies.each do |enemy|
      distance = Gosu.distance(enemy.x, enemy.y, @player.x, @player.y)
      if distance < @player.radius + enemy.radius
        initialize_end(:hit_by_enemy)
      end
    end
    if @player.y < -@player.radius
      initialize_end(:off_top)
    end
  end

  def draw
    case @scene
    when :start
      draw_start
    when :game
      draw_game
    when :end
      draw_end
    end
  end

  def draw_start
    @background_image.draw(0,0,0)
  end
  def draw_game
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
  def button_down(id)
    case @scene
    when :start
      button_down_start(id)
    when :game
      button_down_game(id)
    when :end
      button_down_end(id)
    end
  end
  def button_down_start(id)
    initialize_game
  end
  def button_down_game(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self,  @player.x, @player.y, @player.angle)
      @shooting_sound.play(0.3)
    end
  end
  def button_down_end(id)
    if id == Gosu::KbP 
      initialize_game
    elsif id == Gosu::KbQ 
      exit
    end
  end

  def initialize_game
    @player = Player.new(self)
    @enemies = []
    @bullets = []
    @explosions = []
    @scene = :game
    @enemies_appeared = 0
    @enemies_destroyed = 0
    @enemies_escaped = 0
    @game_music = Gosu::Song.new('sounds/Cephalopod.ogg')
    @game_music.play(true)
    @explosion_sound = Gosu::Sample.new('sounds/explosion.ogg')
    @shooting_sound = Gosu::Sample.new('sounds/shoot.ogg')
  end
  def initialize_end(fate)
    case fate
    when :count_reached
      @message = "You made it!  You destroyed #{@enemies_destroyed} ships"
      @message2= "and #{@enemies_escaped} reached the base."
    when :hit_by_enemy
      @message = "You were struck by an enemy ship."
      @message2 = "Before your ship was destroyed, "
      @message2 += "you took out #{@enemies_destroyed} enemy ships."
    when :off_top
      @message = "You got too close to the enemy mother ship."  
      @message2 = "Before your ship was destroyed, "
      @message2 += "you took out #{@enemies_destroyed} enemy ships."
    end
    @bottom_message = "Press P to play again, or Q to quit."
    @message_font = Gosu::Font.new(self, 'system', 28)
    @credits = []
    y = 700
    File.open('credits.txt').each do |line|
      @credits.push(Credit.new(self,line.chomp,100,y))
      y+=30
    end
    @end_music = Gosu::Song.new('sounds/FromHere.ogg')
    @end_music.play(true)
    @scene = :end
  end

  def update_end
    @credits.each do |credit|
      credit.move
    end

    if @credits.last.y < 150
      @credits.each do |credit|
        credit.reset
      end
    end
  end
  def draw_end
    clip_to(50,140,700,360) do
      @credits.each do |credit|
        credit.draw
      end
    end 
    draw_line(0,140,Gosu::Color::RED,WIDTH,140,Gosu::Color::RED)
    @message_font.draw(@message,40,40,1,1,1,Gosu::Color::FUCHSIA)
    @message_font.draw(@message2,40,75,1,1,1,Gosu::Color::FUCHSIA)
    draw_line(0,500,Gosu::Color::RED,WIDTH,500,Gosu::Color::RED)
    @message_font.draw(@bottom_message,180,540,1,1,1,Gosu::Color::BLUE)
  end
end
window = SectorFive.new
window.show

