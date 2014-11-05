#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'gssapi_api'
require 'socket'
require 'digest'
require 'base64'

class GssServer
  DEBUG = true
  
  attr_accessor :ctx
  
  module Tokens
    KNOCK_KNOCK    = "knock knock\n"
    SRV_REQ_CREDS  = "credentials\n"
    INVALID_TOKEN  = "I don't understand your request\n"
    CLIENT_ACK     = "OK\n"
    ACCESS_GRANTED = "Access Granted\n"
    ACCESS_DENIED  = "Access Denied\n"
    SECRET_REQUEST = "Secret Request\n"  
  end
  
  
  
  
  module TokenMechanisms
    include GSSAPI
    include Tokens
  
  
    def send_msg(gss_token, socket)
      srv_str = gss_token.get_value_as_byte_array
      token_string = Base64.encode64(srv_str)
      send_message(token_string, socket)
      gss_release_buffer gss_token
    end
  
  
    def recv_msg(socket)  
      if recv_string_b64 = read_message(socket)
        recv_string = Base64.decode64(recv_string_b64)
        recv_token = GssBufferDescStruct.new
        recv_token.set_value_from_byte_array(recv_string,recv_string.size)
        recv_token
      end
    end
  
  
    def send_message(msg, socket)
      len = [msg.size].pack('N')
      socket.write(len)
      socket.write(msg)
    end
  
  
    def read_message(socket)
      if len = socket.read(4)
        msg = socket.read(len.unpack('N').to_s.to_i)
        msg
      end
    end
  
  
    def tell_secret(msg, socket)
      buffer_to_encrypt = GssBufferDescStruct.new
      buffer_to_encrypt.set_value_from_byte_array(msg.clone, msg.size)
      session = g_wrap_message(@ctx, buffer_to_encrypt)
      encrypted_buffer = session.token
      send_msg(encrypted_buffer, socket)
    end
  
  
    def read_secret(socket)
      recv_token = recv_msg(socket)
      decrypted_buffer = g_unwrap_message(@ctx, recv_token).token
      secret = decrypted_buffer.get_value_as_byte_array.clone
      gss_release_buffer decrypted_buffer
      secret
    end
  
  end
  
  
  include Socket::Constants
  include Tokens
  include TokenMechanisms
  include GSSAPI
  
  
  
  def initialize
    puts "[#{self.class}] Initializing"
    @secret_info = "Winning lotto: 1 2 4 11 21 9 8"
    @ctx = nil
    keytab_filename = "ruby4.keytab"
    service_name = "rubything/monster.railssecurity.org@RAILSSECURITY.ORG"
    @server_creds = acquire_service_cred(service_name, keytab_filename)
  
  
    server = TCPServer.new("127.0.0.1", 5000)
    while(session = server.accept)
      hello = read_message(session)
      if(hello == KNOCK_KNOCK)
        send_message(SRV_REQ_CREDS, session)
        msg = read_message(session)
        if CLIENT_ACK == msg
          send_message(service_name,session)
          if process_gss_requests(session)
            req = read_message(session)
            if req == SECRET_REQUEST
              # Without crypto -> send_message(@secret_info,session)
              tell_secret(@secret_info, session)
            else
              send_message(INVALID_TOKEN,session)
            end
          else
            send_message(ACCESS_DENIED,session)
          end
        end
      else
        send_message(INVALID_TOKEN,session)
      end
      session.close
    end
  end
  
  
  
  
  def process_gss_requests(session)
    results = []
    authenticated = false
    major_status = -5
    client_princ = nil
    begin
      recv_token = recv_msg(session)
      
      # Pass the token received from the GssClient
      gss_session = 
        accept_sec_context(:ctx   => nil,
                           :creds => @server_creds,
                           :token => recv_token)
      # We reset our context to whatever is passed
      # back from GSSAPI.
      @ctx = gss_session.ctx
      msg = gss_session.token.get_value_as_byte_array
      
      d_results = gss_display_name(gss_session.principal)
      client_princ = d_results[2].get_value_as_string
      puts "[#{self.class}] User requesting 
            authentication: #{client_princ}"
      
      if(msg)
        send_msg(gss_session.token, session)
      end
      major_status = gss_session.major
    end while major_status == GSSAPI::GSS_S_CONTINUE_NEEDED    
    if major_status == GSSAPI::GSS_S_COMPLETE
      authenticated = true
      puts "Client Authenticated!" if DEBUG
    else
      puts "[#{self.class}] Failure: #{major_status}"
      print_results(gss_session.results, self.class.to_s) if DEBUG
    end
    authenticated
  end
  

  
  def self.run
    GssServer.new
  end
  
end

