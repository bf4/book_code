#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Ghee
  module CUD

    # Creates 
    #
    # return json
    #
    def create(attributes)
      connection.post(path_prefix,attributes).body
    end

    # Patchs 
    #
    # return json
    #
    def patch(attributes)
      connection.patch(path_prefix, attributes).body
    end

    # Destroys 
    #
    # return boolean
    #
    def destroy
      connection.delete(path_prefix).status == 204
    end
  end

end
