#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# require 'GSSAPI'
require 'gssapi_api'

include GSSAPI

service_name = "rubything/monster.railssecurity.org@RAILSSECURITY.ORG"
keytab_filename = "ruby4.keytab"

krb_5_gss_register_acceptor_identity(keytab_filename)

buffer = GssBufferDescStruct.new
buffer.set_value_from_string(service_name)

results = gss_import_name(buffer, NT_USER_NAME) 
major_status, minor_status, opaque_name = results
major, minor, creds, oid_set, usage = results

results = gss_release_buffer buffer
print_results(results,"gss_release_buffer")

display_session = display_name(opaque_name)
puts "Server: #{display_session.token.get_value_as_string}"
print_results(results,"gss_display_name")


results = gss_acquire_cred(opaque_name, 0, NULL_OID_SET, GSS_C_ACCEPT)
major, minor, creds, oid_set, usage = results

results = gss_inquire_cred(results[2])
print_results(results,"gss_inquire_cred")

ctx = nil
server_ctx = nil
token = nil
puts "******************"
client_session = init_sec_context({ :opaque_name => opaque_name, :ctx => ctx })
print_results(client_session.results,"init_sec_context")

ctx = client_session.ctx
puts "ctx: #{ctx}"
server_ctx = nil


puts "******************"
server_session = 
  accept_sec_context(:ctx   => server_ctx, 
                     :creds => creds, 
                     :token => client_session.token)

gss_release_buffer client_session.token
print_results(server_session.results, "gss_accept_sec_context")
d_results = gss_display_name(server_session.principal)

puts "Client Princ: #{d_results[2].get_value_as_string}"
puts "\n\n"


puts "******************"
client_session = init_sec_context({ :opaque_name => opaque_name, 
                                    :ctx => ctx, 
                                    :token_from_server => server_session.token
                                  })
                                    
results = gss_release_buffer server_session.token
print_results(results,"gss_release_buffer")

ctx = client_session.ctx
print_results(client_session.results,"init_sec_context")

puts "******************"
client_session = init_sec_context({ :opaque_name => opaque_name, 
                                    :ctx => ctx })
                                    
ctx = client_session.ctx
print_results(client_session.results,"init_sec_context")

results = gss_release_name(opaque_name)
print_results(results, "gss_release_name(opaque_name)")

results = gss_release_name(server_session.principal)
print_results(results, "gss_release_name(server_session.principal)")

results = gss_delete_sec_context(ctx)
print_results(results, "gss_delete_sec_context(server_session.ctx)")


# Now let's test little confidentiality services:
msg_buffer = GssBufferDescStruct.new
msg_buffer.set_value_from_string("My secret message gets bigger!!!!")
results = gss_wrap(ctx, 1, 0, msg_buffer)

print_results(results, "gss_wrap")
secret_msg = results[3]
puts "Buffer: #{results[3].length}"

results = gss_unwrap(server_session.ctx, secret_msg)
print_results(results, "gss_unwrap")

unsecret_msg = results[2]
puts "Buffer: #{results[2].length}"
puts unsecret_msg.get_value_as_string

gss_release_buffer secret_msg
gss_release_buffer unsecret_msg

# 

