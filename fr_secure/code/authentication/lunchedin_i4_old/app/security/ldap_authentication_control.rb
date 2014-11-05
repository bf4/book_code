#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
gem 'ruby-net-ldap'
require 'net/ldap'

module LDAPAuthenticationControl
  def authenticate(username, password)
    ldap = Net::LDAP::new({
      :host => "localhost",
      :port => 389,
      :auth => { 
        :method => :simple, 
        :username => "cn=#{username},ou=people,dc=railssecurity,dc=com",
        :password => password
      }
    })
    user = nil
    if ldap.bind
       # Here we simply fail quietly if the user doesn't exist in the DB.
       # In a production environment, we might want to handle this in a
       # more sophisticated manner.  Perhaps we would forward the ldap 
       # authenticated user to a registration screen.
       user = User.find_by_user_name(username)
       logger.debug "Successfully authenticated #{username} against LDAP"
    end
    user
  end
  
end
