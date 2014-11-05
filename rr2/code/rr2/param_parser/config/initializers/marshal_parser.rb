#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
Mime::Type.register "application/rubymarshal", :marshal
parser = lambda do |raw_body|
  Marshal.load(
    Base64.decode64(raw_body)
  )
end
ParamParser::Application.config.middleware.delete ActionDispatch::ParamsParser
ParamParser::Application.config.middleware.use ActionDispatch::ParamsParser, 
                                               {Mime::MARSHAL => parser}
