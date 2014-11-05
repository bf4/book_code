#---
# Excerpted from "Crafting Rails 4 Applications",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jvrails2 for more book information.
#---
Mime::Type.register "text/html", :html, %w( application/xhtml+xml ), %w( xhtml )
Mime::Type.register "text/plain", :text, [], %w(txt)
Mime::Type.register "text/javascript", :js,
  %w(application/javascript application/x-javascript)
Mime::Type.register "text/css", :css
Mime::Type.register "text/calendar", :ics
Mime::Type.register "text/csv", :csv

Mime::Type.register "image/png", :png, [], %w(png)
Mime::Type.register "image/jpeg", :jpeg, [], %w(jpg jpeg jpe pjpeg)
Mime::Type.register "image/gif", :gif, [], %w(gif)
Mime::Type.register "image/bmp", :bmp, [], %w(bmp)
Mime::Type.register "image/tiff", :tiff, [], %w(tif tiff)

Mime::Type.register "video/mpeg", :mpeg, [], %w(mpg mpeg mpe)

Mime::Type.register "application/xml", :xml, %w(text/xml application/x-xml)
Mime::Type.register "application/rss+xml", :rss
Mime::Type.register "application/atom+xml", :atom
Mime::Type.register "application/x-yaml", :yaml, %w( text/yaml )

Mime::Type.register "multipart/form-data", :multipart_form
Mime::Type.register "application/x-www-form-urlencoded", :url_encoded_form

Mime::Type.register "application/json", :json,
  %w(text/x-json application/jsonrequest)

Mime::Type.register "application/pdf", :pdf, [], %w(pdf)
Mime::Type.register "application/zip", :zip, [], %w(zip)
