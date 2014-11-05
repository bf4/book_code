#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

# templates
DIGITS = <<END_DIGITS.split("\n").map { |row| row.split(" # ") }.transpose
 -  #     #  -  #  -  #     #  -  #  -  #  -  #  -  #  - 
| | #   | #   | #   | # | | # |   # |   #   | # | | # | |
    #     #  -  #  -  #  -  #  -  #  -  #     #  -  #  - 
| | #   | # |   #   | #   | #   | # | | #   | # | | #   |
 -  #     #  -  #  -  #     #  -  #  -  #     #  -  #  - 
END_DIGITS



# number scaling (horizontally and vertically)
def scale( num, size )
  bigger = [ ]
  num.each do |line|
    row = line.dup
    row[1, 1] *= size
    if row.include? "|"
      size.times { bigger << row }
    else
      bigger << row
    end
  end
  bigger
end

# option parsing
s = 2
if ARGV.size >= 2 and ARGV[0] == '-s' and ARGV[1] =~ /^[1-9]\d*$/
  ARGV.shift
  s = ARGV.shift.to_i
end

# digit parsing/usage
unless ARGV.size == 1 and ARGV[0] =~ /^\d+$/
  puts "Usage:  #$0 [-s SIZE] DIGITS"
  exit
end
n = ARGV.shift

# scaling
num = [ ]
n.each_byte do |c|
  num << [" "] * (s * 2 + 3) if num.size > 0
  num << scale(DIGITS[c.chr.to_i], s)
end

# output
num = ([""] * (s * 2 + 3)).zip(*num)
num.each { |l| puts l.join }

