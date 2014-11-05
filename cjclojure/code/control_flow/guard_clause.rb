#---
# Excerpted from "Mastering Clojure Macros",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cjclojure for more book information.
#---
def follow_user(user, user_to_follow)
  if user_to_follow.blocked?(user)
    puts "#{user_to_follow.name} has blocked #{user.name}"
    return
  end
  user.following << user_to_follow
  user_to_follow.followers << user
end
