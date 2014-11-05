#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
<%=form('add', context)%>
<table>
<% @model.history.each do |v| %>
 <tr><td>&nbsp</td><td align='right'><%=h v%></td><td>&nbsp</td></tr>
<% end %>
<tr><th>total</th><th align='right'><%=h @model.amount%></th><td>&nbsp</td></tr>
<tr>
<th align='right'>add</th>
<th><input size="10" type="text" name="value" value="" /></th>
<th><input type="submit" name="Add" value="Add"/></th>
</tr>
<tr><td align="right" colspan="3"><%=a('undo', {}, context)%>undo</a></td></tr>
<tr><td align="right" colspan="3"><%=a('reset', {}, context)%>reset</a></td></tr>
</table>
</form>