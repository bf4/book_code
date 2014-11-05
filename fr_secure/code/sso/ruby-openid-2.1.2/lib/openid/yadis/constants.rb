#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---

require 'openid/yadis/accept'

module OpenID

  module Yadis

    YADIS_HEADER_NAME = 'X-XRDS-Location'
    YADIS_CONTENT_TYPE = 'application/xrds+xml'

    # A value suitable for using as an accept header when performing
    # YADIS discovery, unless the application has special requirements
    YADIS_ACCEPT_HEADER = generate_accept_header(
                                                 ['text/html', 0.3],
                                                 ['application/xhtml+xml', 0.5],
                                                 [YADIS_CONTENT_TYPE, 1.0]
                                                 )

  end

end
