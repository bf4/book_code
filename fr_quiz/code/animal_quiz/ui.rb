#!/usr/bin/env ruby
#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---

class ConsoleUi
  def ask(prompt)
    print prompt + " "
    answer = gets
    answer ? answer.chomp : nil
  end

  def ask_if(prompt)
    answer = ask(prompt)
    answer =~ /^\s*[Yy]/
  end

  def say(*msg)
    puts msg
  end
end
