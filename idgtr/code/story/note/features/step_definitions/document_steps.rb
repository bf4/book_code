#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
When 'I type "$something"' do |something|
  @note.text = something
end
When 'I save the document as "$name" with password "$password"' do  #(1)
  |name, password|

  @note.save_as name, :password => password
end
When 'I open the document "$name" with password "$password"' do
  |name, password|

  @note = Note.open name, :password => password
end
When 'I change the password from "$old" to "$password"' do
  |old, password|

  @note.change_password :old_password => old, :password => password
end
Then 'the text should be "$something"' do |something|
  @note.text.should == something
end
