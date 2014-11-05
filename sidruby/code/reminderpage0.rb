#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
class ReminderPage

  def initialize(reminder)
    @reminder = reminder
    @erb = ERB.new(erb_src)
  end

  def erb_src
    <<EOS
<% bg = BGColor.new %>
<table border="0" cellspacing="0">
<% @reminder.to_a.each do |k, v| %>
<tr <%= bg %>>
 <td><%= k %></td>
 <td><%=h v %></td>
 <td>[<%=a_delete(cgi, k)%>X</a>]</td>
</tr>
<% end %>
<form action="<%=script_name(cgi)%>" method="post">
 <input type="hidden" name="cmd" value="add" />
 <tr <%= bg %>>
 <td><input type="submit" value="add" /></td>
 <td><input type="text" name="item" value="" size="30" /></td>
 <td>&nbsp;</td>
 </tr>
</form>
</table>
EOS
  end

  def to_html(cgi)
    @erb.result(binding)
  rescue DRb::DRbConnError
    %Q+<p>It seems that the reminder server is downed.</p>+
  end

end
