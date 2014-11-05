#---
# Excerpted from "Cucumber Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
#---
module KnowsBookPage
  def visit_book_page(title)
    urls    = {'Cucumber Recipes' => 'http://pragprog.com/titles/dhwcr'}
    url     = urls[title] || raise("Unknown title #{title}")
    browser = Mechanize.new
    @page   = browser.get url
  end

  def find_related_titles
    css = 'table#related-books td.description a'
    @related = @page.search(css).map &:content
  end

  def verify_related_title(title)
    @related.should include(title)
  end
end
