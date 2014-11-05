#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class <%= migration_class_name %> < ActiveRecord::Migration
<%- if migration_action == 'add' -%>
  def change
<% attributes.each do |attribute| -%>
  <%- if attribute.reference? -%>
    add_reference :<%= table_name %>, :<%= attribute.name %><%= attribute.inject_options %>
  <%- else -%>
    add_column :<%= table_name %>, :<%= attribute.name %>, :<%= attribute.type %><%= attribute.inject_options %>
    <%- if attribute.has_index? -%>
    add_index :<%= table_name %>, :<%= attribute.index_name %><%= attribute.inject_index_options %>
    <%- end -%>
  <%- end -%>
<%- end -%>
  end
<%- elsif migration_action == 'join' -%>
  def change
    create_join_table :<%= join_tables.first %>, :<%= join_tables.second %> do |t|
    <%- attributes.each do |attribute| -%>
      <%= '# ' unless attribute.has_index? -%>t.index <%= attribute.index_name %><%= attribute.inject_index_options %>
    <%- end -%>
    end
  end
<%- else -%>
  def change
<% attributes.each do |attribute| -%>
<%- if migration_action -%>
  <%- if attribute.reference? -%>
    remove_reference :<%= table_name %>, :<%= attribute.name %><%= attribute.inject_options %>
  <%- else -%>
    <%- if attribute.has_index? -%>
    remove_index :<%= table_name %>, :<%= attribute.index_name %><%= attribute.inject_index_options %>
    <%- end -%>
    remove_column :<%= table_name %>, :<%= attribute.name %>, :<%= attribute.type %><%= attribute.inject_options %>
  <%- end -%>
<%- end -%>
<%- end -%>
  end
<%- end -%>
end
