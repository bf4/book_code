#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
stage 'default' do
  default_scene 'bookie'
  title 'Bookie'
  location [200, 25]
  size [400, 400]
end

if ENV['BOOKIE_DEV']
  stage 'devtool' do
    default_scene 'devtool'
    title 'Dev Tool'
    location [50, 25]
    size [100, 100]
    background_color 'transparent'
    framed false
  end
end
