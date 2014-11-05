#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
<% module_namespacing do -%>

class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>,
    only: [:show, :edit, :update, :destroy]

  # GET <%= route_url %>
  def index
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    respond_with(@<%= plural_table_name %>)
  end

  # GET <%= route_url %>/1
  def show
    respond_with(@<%= singular_table_name %>)
  end

  # GET <%= route_url %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= singular_table_name %>)
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name,
                                        "#{singular_table_name}_params") %>
    @<%= orm_instance.save %>
    respond_with(@<%= singular_table_name %>)
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    @<%= orm_instance.update("#{singular_table_name}_params") %>
    respond_with(@<%= singular_table_name %>)
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    respond_with(@<%= singular_table_name %>)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  # Only allow a trusted parameter "white list" through.
  def <%= "#{singular_table_name}_params" %>
    <%- if attributes_names.empty? -%>
    params[<%= ":#{singular_table_name}" %>]
    <%- else -%>
    params.require(<%= ":#{singular_table_name}" %>).
      permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
    <%- end -%>
  end
end
<% end -%>