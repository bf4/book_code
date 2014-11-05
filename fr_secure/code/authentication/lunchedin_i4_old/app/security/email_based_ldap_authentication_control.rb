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

module EmailBasedLDAPAuthenticationControl
  def authenticate(mail, password)
    ldap_con = initialize_ldap_con(
      'cn=Manager,dc=railssecurity,dc=com','secret')
    treebase = "DC=railssecurity,DC=com" 
    mail_filter = Net::LDAP::Filter.eq( "mail", mail ) 
    op_filter = 
      Net::LDAP::Filter.eq( "objectClass", "organizationalPerson" ) 
    dn = String.new
    ldap_con.search( 
      :base => treebase, 
      :filter => op_filter & mail_filter, 
      :attributes=> 'dn') { |entry|
        dn = entry.dn
      }
    user = nil
    unless dn.empty?
      ldap_con = initialize_ldap_con(dn,password)
      if ldap_con.bind
        user = User.find_by_email(mail)
      end
    end
    user
  end

  def initialize_ldap_con(user_name, password)
    Net::LDAP.new({
      :host => 'localhost', 
      :port => 389, 
      :auth => { 
        :method => :simple, 
        :username => user_name, 
        :password => password 
      }
    })
  end
  
end
