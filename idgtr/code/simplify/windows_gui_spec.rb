#---
# Excerpted from "Scripted GUI Testing with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/idgtr for more book information.
#---
require 'windows_gui'

describe WindowsGui do                       #(1)
  include WindowsGui
  
  it 'wraps a Windows call with a method' do
    find_window(nil, nil).should_not == 0    #(2)
  end

  it 'enforces the argument count' do
    lambda {find_window}.should raise_error  #(3)
  end
end


describe String, '#snake_case' do
  it 'transforms CamelCase strings' do
    'GetCharWidth32'.snake_case.should == 'get_char_width_32'
  end
  
  it 'leaves snake_case strings intact' do
    'keybd_event'.snake_case.should == 'keybd_event'
  end
end
