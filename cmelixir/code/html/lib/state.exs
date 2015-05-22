#---
# Excerpted from "Metaprogramming Elixir",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/cmelixir for more book information.
#---
markup do              # buff = ""
  tag :table do        # buff = buff <> "<table>
    tag :tr do         # buff = buff <> "<tr>"

      for i <- 0..3 do # >------>------->----------->
        tag :td do     # |  buff = buff <> "<td>"   |
          text "#{i}"  # ^  buff = buff <> "#{i}"   v
        end            # |  buff = buff <> "</td>"  |
      end              # <------<-------<-----------<

    end                # buff = buff <> "</tr>"
  end                  # buff = buff <> "</table>"
end                    # buff

iex> buff
"<table><tr></tr></table>"
