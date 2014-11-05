#---
# Excerpted from "Seven Web Frameworks in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
#---
TorqueBox.configure do # (1)
  web do # (2)
    context "/rubypoly"
  end
  options_for :messaging, :default_message_encoding => :edn # (3)

  topic "topic.poly" do # (4)
    processor PrintProcessor # (5)
  end
end
