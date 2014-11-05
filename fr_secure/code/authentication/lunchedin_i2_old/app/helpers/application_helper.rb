#---
# Excerpted from "Security on Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_secure for more book information.
#---
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def tag_cloud(tags, classes)
    return unless tags
    
    # max, min = 0, 0
    # tags.each do |t|
    #   max = t.count.to_i if t.count.to_i > max
    #   min = t.count.to_i if t.count.to_i < min
    # end
    # 
    # divisor = ((max - min) / classes.size) + 1
    
    # TODO add count

    tags.each do |t|
      yield t.name, classes[1] #[(t.count.to_i - min) / divisor]
    end
  end
end
