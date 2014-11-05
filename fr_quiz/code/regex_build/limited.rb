#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
def Regexp.build(*args)
  args = args.map {|arg| Array(arg) }.flatten.uniq.sort
  neg, pos = args.partition {|arg| arg < 0 }
  / \A (?: -0*#{Regexp.union(*neg.map {|arg| (-arg).to_s })} |
            0*#{Regexp.union(*pos.map {|arg| arg.to_s })} ) \z /x
end
