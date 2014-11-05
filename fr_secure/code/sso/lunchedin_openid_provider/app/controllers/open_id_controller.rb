#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require "openid"
require "openid/consumer/discovery"
require 'openid/extensions/sreg'
require 'openid/extensions/pape'
require 'openid/store/filesystem'


class OpenIdController < ApplicationController
  include OpenID::Server
  skip_before_filter :check_authentication, :only => ["index", "user_page"]
  protect_from_forgery :except => :index
  
  def index
    begin
      openid_request = session[:last_oidreq]
      openid_request ||= server.decode_request(params)
      session[:last_oidreq] = nil
      
      case openid_request
      when nil
        render :text => "This is an OpenID server.", :status => 500
      when CheckIDRequest
        handle_check_id_request(openid_request)    # (1)
      when CheckAuthRequest
        handle_check_auth_request(openid_request)  # (2)
      when AssociateRequest
        handle_associate_request(openid_request)   # (3)
      else
        render :text => "Some general problem", :status => 500
      end
    rescue ProtocolError => e
      render :text => "Problem processing OpenID Request", :status => 500
      logger.debug { e.to_s }
    end
  end
  
  
  
  def user_page
    respond_to do |format|
      format.xrds do
        render_user_xrds
      end
      format.html do
        @xrds_url = url_for(:controller => 'open_id', 
                            :action => :user_page,
                            :format => :xrds)
        response.headers['X-XRDS-Location'] = @xrds_url
        render :action => :user_page, :layout => false
      end
    end
  end
  
  
  
  def decision
    openid_request = session[:last_oidreq]
    # Not sure we should nil this out here.
    session[:last_oidreq] = nil
    if params[:yes].nil?
      redirect_to openid_request.cancel_url
    else
      identity = openid_request.identity
      session[:approvals] ||= []
      session[:approvals] << openid_request.trust_root
      openid_response = openid_request.answer(true, nil, identity)
      add_sreg(openid_request, openid_response)
      render_response(openid_response)
    end
  end
  
  
  protected
  
  
  # Responding to Authentication Requests
  # http://openid.net/specs/\
  # openid-authentication-2_0.html#responding_to_authentication
  def handle_check_auth_request(openid_request)
    render_response(server.handle_request(openid_request))
  end
  

  
  # Establishing Associations
  # http://openid.net/specs/openid-authentication-2_0.html#associations
  # This is when the openid.mode == "associate"
  def handle_associate_request(openid_request)
    render_response(server.handle_request(openid_request))
  end
  
  
  
  
  def handle_check_id_request(openid_request)
    unless session[:user_id]
      session[:last_oidreq] = openid_request
      redirect_to :controller => :session
    else
  
  
      openid_response = nil
      identity = openid_request.identity
        # We need to choose an identifier if the RP has send us
      # "http://specs.openid.net/auth/2.0/identifier_select"
      if openid_request.id_select
        if openid_request.immediate
          # If it's 'immediate' and the identifier_select
          # has been specified we must ask that the User 
          # take further action.
          openid_response = openid_request.answer(false)
          render_response(openid_response)
        else
          # Since the user is logged in, we can provide the
          # identity.
          identity = url_for_user
        end
      end
  

  
      if is_authorized(identity, openid_request.trust_root)
        # Since the site is authorized, we will render 
        # and authorize response
        openid_response = openid_request.answer(true, nil, identity)
        render_response(openid_response)
  
  
      elsif openid_request.immediate
        # We have to answer negatively since 'immediate' 
        # has been requested and the user has not authorized.
        server_url = url_for(:action => 'index')
        openid_response = openid_request.answer(false, server_url)
        render_response(openid_response)
      else
        # We will give the user the opportunity to authorize
        # this particular request.
        session[:last_oidreq] = openid_request
        @openid_request = openid_request
        @url_for_user = url_for_user
        render :action => :decide
      end
    end
  end
  
  
  
  
  def approved(trust_root)
    if session[:approvals].nil?
      false
    else
      session[:approvals].member?(trust_root)
    end
  end
  
  
  
  def is_authorized(identity_url, trust_root)
    session[:user_id] and (identity_url == url_for_user) and approved(trust_root)
  end
  
  
  
  
  def url_for_user
    server_url = url_for(:action => 'index', :only_path => false)
    user = User.find(session[:user_id])
    "#{server_url}/user_page/#{user.username}"
  end
  
  
  
  def server
    if @server.nil?
      server_url = url_for(:controller => :open_id, 
                           :action => 'index', :only_path => false)
      dir = Pathname.new(RAILS_ROOT).join('db').join('openid-store')
      store = OpenID::Store::Filesystem.new(dir)
      @server = Server.new(store, server_url)
    end
    @server
  end
  
  
  
  def render_response(openid_response)
    if openid_response.needs_signing
      signed_response = server.signatory.sign(openid_response)
    end
    web_response = server.encode_response(openid_response)
    case web_response.code
    when HTTP_OK
      render :text => web_response.body, :status => 200
    when HTTP_REDIRECT
      redirect_to web_response.headers['location']
    else
      render :text => web_response.body, :status => 400
    end
  end
  
  
  
  def render_user_xrds
    @types = [ OpenID::OPENID_2_0_TYPE,
          OpenID::OPENID_1_0_TYPE,
          OpenID::SREG_URI ]
    render :action => :xrds, :format => :xrds
  end
  
  
    
  
  # This could be refactored into the User Model
  def add_sreg(openid_request, openid_response)
    # check for Simple Registration arguments and respond
    sregreq = OpenID::SReg::Request.from_openid_request(openid_request)
    if sregreq    
      # In a real application the user should be asked for 
      # permission to release registration data like this.
      user = User.find(session[:user_id])
      sreg_data = {
        'nickname' => user.username,
        'fullname' => "#{user.first_name} #{user.last_name}",
        'email'    => user.email,
        'postcode' => user.zip_code
      }
      sregresp = OpenID::SReg::Response.extract_response(sregreq, sreg_data)
      openid_response.add_extension(sregresp)
    end
  end
  
  
end
