#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
module SeleniumOnRails::Renderer
  include SeleniumOnRails::Paths
  
  def render_test_case filename
    @template.extend SeleniumOnRails::PartialsSupport
    @page_title = test_case_name filename
    output = render_to_string :file => filename, :locals => {"page_title" => @page_title}
    layout = (output =~ /<html>/i ? false : layout_path)
    render :text => output, :layout => layout

    headers['Cache-control'] = 'no-cache'
    headers['Pragma'] = 'no-cache'
    headers['Expires'] = '-1'
  end
  
  def test_case_name filename
    File.basename(filename).sub(/\..*/,'').humanize
  end

end