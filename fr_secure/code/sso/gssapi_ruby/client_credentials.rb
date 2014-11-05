#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

require 'gssapi_api'
include GSSAPI

client_name = "draphael@RAILSSECURITY.ORG"
buffer = GssBufferDescStruct.new
buffer.set_value_from_string(client_name)



results = gss_import_name(buffer, NT_USER_NAME)
major_status, minor_status, client_opaque_name = results
print_results(results,"gss_import_name")
results = gss_release_buffer buffer
print_results(results,"gss_release_buffer")



results = gss_acquire_cred(client_opaque_name, 0, NULL_OID_SET, GSS_C_INITIATE)
print_results(results,"gss_acquire_cred")





