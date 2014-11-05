#---
# Excerpted from "The RSpec Book",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/achbd for more book information.
#---
When /^I create a movie Caddyshack in the Comedy genre$/ do
  get_via_redirect movies_path
  assert_select "a[href=?]", new_movie_path, "Add Movie"

  get_via_redirect new_movie_path

  assert_select "form[action=?][method=post]", movies_path do
    assert_select "input[name=?][type=text]", "movie[title]"
    assert_select "select[name=?]", "movie[release_year]"
    assert_select "input[name=?][type=checkbox][value=?]", "genres[]", @comedy.id
  end

  post_via_redirect movies_path, :genres => [@comedy.id], :movie =>
    { :title => "Caddyshack", :release_year => "1980" }
  assert_response :success
end

Then /^Caddyshack should be in the Comedy genre$/ do
  visit genres_path
  click_link "Comedy"
  response.should contain("1 movie")
  response.should contain("Caddyshack")
end
