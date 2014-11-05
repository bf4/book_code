#---
# Excerpted from "Rails 4 Test Prescriptions",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/nrtest2 for more book information.
#---
class AvatarAdapter

  attr_accessor :email, :gravatar

  def initialize(email)
    @email = email
    @gravatar = Gravatar.new(email)
  end

  def image_url
    gravatar.image_data
  end

end
