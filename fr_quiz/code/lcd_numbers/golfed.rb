#---
# Excerpted from "Best of Ruby Quiz"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_quiz for more book information.
#---
s=(s=$*.index"-s")?$*.slice!(s,2)[1].to_i: 2
d,="\21\265\22H\245\10-\0\23".unpack"B*"
f=" "
o=48
5.times{|x|((t=x%2==0)?1:s).times{puts$*[0].split('').map{|z|u=d[7*z.to_i,7]
t ?u[x/2*3]>o ?f*s+f+f:f+"-"*s+f:(u[h=x*4/3]>o ?f:"|")+f*s+(u[h+1]>o ?f:"|")}*f}}
