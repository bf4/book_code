#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
module LCD
  extend self

  # Digits are represented by simple bit masks. Each bit identifies
  # whether a line should be displayed. The following ASCII
  # graphic shows the mapping from bit position to the belonging line.
  #
  #  =6
  # 5  4
  #  =3
  # 2  1
  #  =0
  Digits = [0b1110111, 0b0100100, 0b1011101, 0b1101101, 0b0101110,
            0b1101011, 0b1111011, 0b0100101, 0b1111111, 0b1101111,
            0b0001000, 0b1111000] # Minus, Dot
  Top, TopLeft, TopRight, Middle, BottomLeft, BottomRight, Bottom = *0 .. 6
  SpecialDigits = { "-" => 10, "." => 11 }


  private

  def line(digit, bit, char = "|")
    (digit & 1 << bit).zero? ? " " : char
  end

  def horizontal(digit, size, bit)
    [" " + line(digit, bit, "-") * size + " "]
  end

  def vertical(digit, size, left_bit, right_bit)
    [line(digit, left_bit) + " " * size + line(digit, right_bit)] * size
  end

  def digit(digit, size)
    digit = Digits[digit.to_i]
    horizontal(digit, size, Top) +
    vertical(digit, size, TopLeft, TopRight) +
    horizontal(digit, size, Middle) +
    vertical(digit, size, BottomLeft, BottomRight) +
    horizontal(digit, size, Bottom)
  end

  public

  def render(number, size = 1)
    number = number.to_s
    raise(ArgumentError, "size has to be > 0") unless size > 0
    raise(ArgumentError, "Invalid number") unless number[/\A[\d.-]+\Z/]

    number.scan(/./).map do |digit|
      digit(SpecialDigits[digit] || digit, size)
    end.transpose.map do |line|
      line.join(" ")
    end.join("\n")
  end
end

if __FILE__ == $0
  require 'optparse'
  options = { :size => 2 }
  number = ARGV.pop

  ARGV.options do |opts|
    script_name = File.basename($0)
    opts.banner = "Usage: ruby #{script_name} [options] number"

    opts.separator ""

    opts.on("-s", "--size size", Numeric,
      "Specify the size of line segments.",
      "Default: 2"
    ) { |options[:size]| }
    
    opts.separator ""

    opts.on("-h", "--help", "Show this help message.") { puts opts; exit }

    opts.parse!
  end 

  puts LCD.render(number, options[:size])
end
