#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
require 'GSSAPI'
include GSSAPI

name = "rubything/monster.railssecurity.org@RAILSSECURITY.ORG"

# name = "draphael@RAILSSECURITY.ORG"
# name = "rubything@RAILSSECURITY.ORG"

keytab_filename = "/Users/draphael/Desktop/ruby3.keytab"
krb_5_gss_register_acceptor_identity(keytab_filename)
  
buffer = GssBufferDescStruct.new
buffer.set_value_from_string(name)

results = gss_import_name(buffer, nt_user_name) 
major, minor, imported_name = results
# puts "\ngss_import_name() results:"
major_status, minor_status, opaque_name = results
# print_errors(results[0],results[1])
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end

results = gss_display_name(opaque_name)
# puts "\ngss_display_name() results"
# print_errors(results[0],results[1])
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end
puts "Value: #{results[2].get_value_as_string}"
# 
# results = gss_acquire_cred(nil, 0, null_oid_set, GSS_C_ACCEPT)
# puts "\ngss_acquire_cred() results"
# print_errors(results[0],results[1])
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end
# 
# results = gss_inquire_cred(results[2])
# puts "\ngss_inquire_cred() results"
# print_errors(results[0],results[1])
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end

results = gss_acquire_cred(opaque_name, 0, null_oid_set, GSS_C_ACCEPT)
major, minor, creds, oid_set, usage = results
puts "\ngss_acquire_cred() results"
print_errors(results[0],results[1])
results.each do |r|
  puts "#{r} -> #{r.class}"
end

results = gss_inquire_cred(results[2])
puts "\ngss_inquire_cred() results"
print_errors(results[0],results[1])
results.each do |r|
  puts "#{r} -> #{r.class}"
end

# // ->[MajorStatus, MinorStatus, ReturnedContext, actual_mech_type, output_token, ret_flags, time_rec]
# OM_uint32 KRB5_CALLCONV gss_init_sec_context
#   (
#   OM_uint32             *OUT,   /* minor_status */
#   gss_cred_id_t           IN,   /* claimant_cred_handle */
#   gss_ctx_id_t        *INOUT,   /* context_handle */
#   gss_name_t              IN,   /* target_name */
#   gss_OID                 IN,   /* mech_type (used to be const) should use -> GSS_C_NO_OID for KRB5*/
#   OM_uint32               IN,   /* req_flags */
#   OM_uint32               IN,   /* time_req */
#   gss_channel_bindings_t  IN,   /* input_chan_bindings */
#   gss_buffer_t            IN,   /* input_token */
#   gss_OID *              OUT,   /* actual_mech_type */
#   gss_buffer_t           OUT,   /* output_token */
#   OM_uint32 *            OUT,   /* ret_flags */
#   OM_uint32 *            OUT    /* time_rec */
#   );

# 	const OM_uint32		reqFlags				= GSS_C_MUTUAL_FLAG | GSS_C_REPLAY_FLAG | GSS_C_DELEG_FLAG;

ctx = nil
server_ctx = nil

puts "Creds: #{creds}"
puts "\ngss_init_sec_context results"
results = gss_init_sec_context(
              nil, #creds
              ctx, #no ctx yet
              imported_name,
              nil, # Mech
              GSS_C_MUTUAL_FLAG | GSS_C_REPLAY_FLAG | GSS_C_DELEG_FLAG,
              20000000,
              nil,#Bindings
              nil #Input token
              )
              
ctx   = results[2]        
token = results[4]
        
puts "ctx after: #{ctx}"

print_errors(results[0],results[1])
results.each do |r|
  puts "#{r} -> #{r.class}"
end

buffer = GssBufferDescStruct.new
puts "Creds: #{creds}"
puts "\ngss_accept_sec_context results"

puts "\nAccepting token: #{token}"
puts "\tLength: #{token.length}"
results = gss_accept_sec_context(
              server_ctx, #no ctx yet
              creds,
              token,
              nil
              )
              
server_ctx = results[2]
           
puts "ctx after: #{server_ctx}"
recv_tok = results[5]
print_errors(results[0],results[1])
results.each do |r|
  puts "#{r} -> #{r.class}"
end


puts "\ngss_init_sec_context results"
results = gss_init_sec_context(
              nil,
              ctx, #no ctx yet
              imported_name,
              nil,
              GSS_C_MUTUAL_FLAG | GSS_C_REPLAY_FLAG | GSS_C_DELEG_FLAG,
              20000000,
              nil,
              recv_tok
              )
              
# ctx   = results[2]        
token = results[4]
        
puts "ctx after: #{ctx}"

print_errors(results[0],results[1])
results.each do |r|
  puts "#{r} -> #{r.class}"
end

puts "\ngss_init_sec_context results"
results = gss_init_sec_context(
              nil,
              ctx, #no ctx yet
              imported_name,
              nil,
              GSS_C_MUTUAL_FLAG | GSS_C_REPLAY_FLAG | GSS_C_DELEG_FLAG,
              20000000,
              nil,
              recv_tok
              )
              
# ctx   = results[2]        
token = results[4]
        
puts "ctx after: #{ctx}"

print_errors(results[0],results[1])
results.each do |r|
  puts "#{r} -> #{r.class}"
end

results = gss_delete_sec_context(ctx)
puts "\ngss_delete_sec_context results"
print_errors(results[0],results[1])
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end

results = gss_delete_sec_context(server_ctx)
puts "\ngss_delete_sec_context results"
print_errors(results[0],results[1])
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end

results = gss_release_buffer(token)
puts "\ngss_release_buffer results"
print_errors(results[0],results[1])
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end


# print_errors(results[0],0)
# results.each do |r|
#   puts "#{r} -> #{r.class}"
# end

# results = gss_delete_sec_context(server_ctx)
# print_errors(results[0],0)
# results.each do |r|
#   puts "#{r}"
# end

# begin


# end while results[0] == GSS_S_CONTINUE_NEEDED




