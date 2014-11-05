#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  fixtures :users

  def test_salts
    assert(users(:bob).salt == "salt1234567890", "Expecting salt1234567890.  Was #{users(:bob).salt}")
    assert(users(:dave).salt == "salt1234567890", "Expecting salt1234567890.  Was #{users(:dave).salt}")    
    assert(users(:bob).password == Digest::SHA1.hexdigest("#{users(:bob).salt}hello"))
    assert(users(:dave).password == Digest::SHA1.hexdigest("#{users(:dave).salt}hello"))    
  end
  
  def test_bind_vars
    backslashes ="\\\\"
    User.quote_value(backslashes)


    
    username = 'dave " or 1=1; --\""'
    q_username = User.quote_value(username)
    assert(q_username == "'dave \\\" or 1=1; --\\\\\\\"\\\"'")
    

    u = User.new(:first_name => backslashes, :user_name => "username", :password => "foo")
    u.save(false)
        
    
    username = 'dave " or 1=1; --\""'
    password = 'letmein'
    User.find(:all, :conditions => ["user_name = ?", username])
    
    
    
    username = 'dave " or 1=1; --\""'    
    password = 'letmein'    
    bind_vars = {:username => username, :password => 'letmein'}
    User.find(:all, :conditions => 
      ["user_name = :username and password = :password", bind_vars])
    

  end
  
  def test_system_call
    
    command = "ls"
    system("#{command} > __tmp.file")  
    file = File.open("__tmp.file")
    x = file.read.insert(0,"<br/>").insert(-1,"</div>").split.join("<br/>")
    x.insert(0, "<div id='bad_ways'>")
    puts x
    File.delete("__tmp.file")
    
  end
  
  def test_extra_code_for_chapter
    
    
    # This is an example of what not to do.
    input = '" or 1=1; --\""'
    input.gsub(/;|--|'|"|\\/, "*") # => "* or 1=1* ****"
    
    
    
    # This is an example of what not to do.
    input = '" or 1=1; --\""'
    input.gsub(/[^a-zA-Z0-9= ]/, "*") # => "* or 1=1* *****"
    
    
    
    # This is an example of what not to do.
    input = "O'Reilly"
    input.gsub(/[^a-zA-Z0-9= ]/, "*") # => "O*Reilly"
    
    
    
    # This is a better example, but not perfect.
    input = "O'Reilly"
    input.gsub(/\'/, "''") # => "O''Reilly"
    

    
    # This is an example of what to do.
    input = "O'Reilly, the \"Daredevil.\""
    input.gsub(/\\/, '\&\&').gsub(/'/, "''") # => "O''Reilly, the \"Daredevil.\""
    

    
    # This is an example of what to do.
    input = '" or 1=1; --\""'
    input.gsub(/\\/, '\&\&').gsub(/'/, "''") # => "\" or 1=1; --\\\\\"\""
    
   
    
    # This is an example of what not to do.
    input = "6"
    sql_statement = "select * from foo where id = #{input}"
    puts sql_statement # >> "select * from foo where id = 6"
    
   
    
    # This is an example of what not to do.
    input = "6 or 1=1"
    sql_statement = "select * from foo where id = #{input}"
    puts sql_statement # >> "select * from foo where id = 6 or 1=1"
    
    
    
    # This is a better example, but not perfect.
    input = "6 or 1=1"
    sql_statement = "select * from foo where id = #{input.to_i}"
    puts sql_statement # >> select * from foo where id = 6
    
        
    # for x in (1..300)
    #   y = "\303\/#{x}"
    #   p y
    # end
    
    $KCODE="NONE"
    p "¿"
    p "ä"    
    p name = "G\303\277 ; select * from users"
    p name.gsub! "'", "\'"
    u = User.create(:first_name => name, :last_name =>name, :user_name => "bs", :password => "foo", :zip_code => "75023", :email => "foo@gmail.com")
    p "user:: #{u.inspect}"
    p "1--;".to_i
    $KCODE="UTF8"
  end
end


