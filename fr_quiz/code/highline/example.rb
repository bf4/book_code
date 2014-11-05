#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
def ask(prompt)
  loop do
    print prompt, ' '
    $stdout.flush
    s = gets
    exit if s == nil
    s.chomp!
    if s == 'y' or s == 'yes'
      return true
    elsif s == 'n' or s == 'no'
      return false
    else
      $stderr.puts "Please answer yes or no."
    end
  end
end
