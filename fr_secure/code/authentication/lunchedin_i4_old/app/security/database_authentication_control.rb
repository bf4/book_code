#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
module DatabaseAuthenticationControl
  def authenticate(username, password)
    @user = User.find_by_user_name(username) 
    if(!@user.nil? && @user.password == Digest::SHA1.hexdigest("#{@user.salt}#{password}")) 
      return @user
    else
      return nil
    end
  end  
end
