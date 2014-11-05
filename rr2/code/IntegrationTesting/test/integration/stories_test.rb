#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
require "#{File.dirname(__FILE__)}/../test_helper"

class StoriesTest < ActionController::IntegrationTest
  fixtures :accounts, :ledgers, :registers, :people

  def test_signup_new_person
    get "/login"
    assert_response :success
    assert_template "login/index"

    get "/signup"
    assert_response :success
    assert_template "signup/index"

    post "/signup", :name => "Bob", :user_name => "bob", :password => "secret"
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template "ledger/index"
  end                             
end                     

class StoriesTest < ActionController::IntegrationTest
  def test_signup_new_person
    go_to_login    
    go_to_signup
    signup :name => "Bob", :user_name => "bob", :password => "secret"
  end

  private
  def go_to_login
    get "/login"
    assert_response :success
    assert_template "login/index"
  end

  def go_to_signup
    get "/signup"
    assert_response :success
    assert_template "signup/index"
  end

  def signup(options)
    post "/signup", options
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template "ledger/index"
  end                         
end

class StoriesTest < ActionController::IntegrationTest
  fixtures :accounts, :ledgers, :registers, :people

  def test_signup_new_person
    new_session do |bob|
      bob.goes_to_login
      bob.goes_to_signup
      bob.signs_up_with :name => "Bob", :user_name => "bob", :password => "secret"
    end
  end

  private

  module MyTestingDSL
    def goes_to_login
      get "/login"
      assert_response :success
      assert_template "login/index"
    end
    
    def goes_to_signup
      get "/signup"
      assert_response :success
      assert_template "signup/index"
    end
    
    def signs_up_with(options)   
      post "/signup", options
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template "ledger/index"
    end
  end
  
  def new_session
    open_session do |sess|
      sess.extend(MyTestingDSL)
      yield sess if block_given?
    end
  end
end
class StoriesTest < ActionController::IntegrationTest
  fixtures :accounts, :ledgers, :registers, :people
                                                        
    def test_multiple_users
      jim = new_session_as(:jim)
      bob = new_session_as(:bob)
      stacey = new_session_as(:stacey)

      jim.selects_ledger(:jims)
      jim.adds_account(:name => "checking")
      bob.goes_to_preferences
      stacey.cancels_account
    end

    private

    module MyTestingDSL
      attr_reader :person
      def logs_in_as(person)
        @person = people(person)
        post authenticate_url, :user_name => @person.user_name, :password => @person.password
        is_redirected_to "ledger/list"
      end
      def goes_to_preferences
        # ...
      end         
      def cancels_account
        # ...
      end
    end

    def new_session_as(person)
      new_session do |sess|
        sess.goes_to_login
        sess.logs_in_as(person)
        yield sess if block_given?
      end
    end 
end                           
class StoriesTest < ActionController::IntegrationTest
    def test_add_new_account
      new_session_as(:jim) do |jim|
        jim.selects_ledger(:jims)
        jim.adds_account(:name => "credit card")
      end
    end

    private

    module MyTestingDSL
      attr_accessor :ledger
      
      def is_redirected_to(template)
        assert_response :redirect
        follow_redirect!
        assert_response :success
        assert_template(template)
      end
      
      def selects_ledger(ledger)  
        @ledger = ledgers(ledger)
        get ledger_url(:id => @ledger.id)
        assert_response :success
        assert_template "ledger/index"
      end
      
      def adds_account(options) 
        post new_account_url(:id => @ledger.id), options
        is_redirected_to "register/index"
      end
    end 
  end                                       
