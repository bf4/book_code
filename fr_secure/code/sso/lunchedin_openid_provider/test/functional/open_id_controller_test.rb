#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'test_helper'

class OpenIdControllerTest < ActionController::TestCase
  tests OpenIdController
  OPENID2_NS = 'http://specs.openid.net/auth/2.0'
  
  test "Invalid OpenID Request" do
    get :index
    assert_response 500
  end
  
  test "not logged in" do
    req_params = {
      "openid.ns" => OPENID2_NS, 
      "openid.mode" => "checkid_setup",
      "openid.realm" => "http://127.0.0.1",
      "openid.return_to" => "http://127.0.0.1/some/path/foo"
    }
    
    get :index, req_params
    
    assert_response 302, @response.body
  end
  
  test "logged in" do
    @request.session[:user_id] = "joeuser"
    
    req_params = {
      "openid.ns" => OPENID2_NS, 
      "openid.mode" => "checkid_setup",
      "openid.realm" => "http://127.0.0.1",
      "openid.return_to" => "http://127.0.0.1/some/path/foo"
    }
    
    get :index, req_params
    assert_response 200, @response.body
  end
  
  test "successful redirect" do
    @request.session[:user_id] = "joeuser"
    @request.session[:approvals] = ["http://127.0.0.1"]
  
    req_params = {
      "openid.ns" => OPENID2_NS,
      "openid.mode" => "checkid_setup",
      "openid.realm" => "http://127.0.0.1",
      "openid.return_to" => "http://127.0.0.1/some/path/foo",
      "openid.claimed_id" => "http://test.host/open_id/user_page/joeuser",
      "openid.identity"   => "http://test.host/open_id/user_page/joeuser"
    }
    
    get :index, req_params
    assert_response 302, @response.body
  end
  
  test "unsuccessful redirect" do
    @request.session[:user_id] = "joeuser"
    @request.session[:approvals] = "http://127.0.0.1"
    
    req_params = {
      "openid.ns" => OPENID2_NS, 
      "openid.mode" => "checkid_setup",
      # Some domain that the user hasn't approved for OpenID 
      # authentication
      "openid.realm" => "http://foobar.com",
      "openid.return_to" => "http://foobar.com/some/path/foo",
      "openid.claimed_id" => "http://test.host/open_id/user_page/joeuser",
      "openid.identity" => "http://test.host/open_id/user_page/joeuser"
    }
    
    get :index, req_params
    assert_response 200, @response.body
  end
  
  test "authentication request" do
    # @request.session[:user_id] = "joeuser"
    # @request.session[:approvals] = "http://127.0.0.1"
    puts "@controller.server: #{@controller.send(:server)}"
    
    assoc_req_params = {
      "openid.ns" => OPENID2_NS, 
      "openid.mode" => "associate",
      "openid.assoc_type" => "HMAC-SHA1",
      "openid.session_type" => "no-encryption"
    }
    
    get :index, assoc_req_params
    assert_response 200, @response.body
    
    puts "response: #{@response.body}"
    
    puts "@controller.server: #{@controller.send(:server)}"
    
    req_params = {
      "openid.ns" => OPENID2_NS, 
      "openid.mode" => "check_authentication",
      "openid.op_endpoint" => "http://test.host",
      "openid.claimed_id" => "http://test.host/open_id/user/joeuser",
      "openid.identity" => "http://test.host/open_id/user/joeuser",
      "openid.return_to" => "http://foobar.com/some/path/foo",
      "openid.realm" => "http://foobar.com",
      "openid.response_nonce" => "2005-05-15T17:11:51ZUNIQUE",
      "openid.assoc_handle" => "{HMAC-SHA1}{49cfe254}{IE9BtA==}",
      "openid.signed" => "op_endpoint,return_to,response_nonce,assoc_handle,claimed_id,identity",
      "openid.sig" => Base64::encode64(Digest::SHA1.digest("secret"))
    }
    
    get :index, req_params
    assert_response 200, @response.body
  end
end
