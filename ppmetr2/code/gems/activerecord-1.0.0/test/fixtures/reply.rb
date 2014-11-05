#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Reply < Topic
  belongs_to :topic, :foreign_key => "parent_id", :counter_cache => true
  
  attr_accessible :title, :author_name, :author_email_address, :written_on, :content, :last_read

  def validate
    errors.add("title", "Empty")   unless attribute_present? "title"
    errors.add("content", "Empty") unless attribute_present? "content"
  end
  
  def validate_on_create
    errors.add("title", "is Wrong Create") if attribute_present?("title") && title == "Wrong Create"
    if attribute_present?("title") && attribute_present?("content") && content == "Mismatch"
      errors.add("title", "is Content Mismatch") 
    end
  end

  def validate_on_update
    errors.add("title", "is Wrong Update") if attribute_present?("title") && title == "Wrong Update"
  end
end