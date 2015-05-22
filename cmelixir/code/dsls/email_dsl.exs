#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
defmodule UserWelcomeEmail do
  use Emailer

  from     "info@example.com"
  reply_to "info@example.com"
  subject  "Welcome!"

  def deliver(to, body) do
    send_email to: to, body: body
  end
end

UserWelcomeEmail.deliver("user@example.com", "Hello there!")
