#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/helper')

describe "Rendering Extensions" do
  context 'for haml' do
    should 'render haml_tag correctly' do
      mock_app do
        get('/') { render :haml, '-haml_tag :div'}
      end

      get '/'
      assert_match '<div></div>', last_response.body
    end
  end
end
