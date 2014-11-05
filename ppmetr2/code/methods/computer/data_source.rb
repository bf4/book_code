#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
# In this example, we just fake the real service.

class DS
  def initialize # connect to data source...
  end

  def get_cpu_info(workstation_id) # ...
      "2.9 Ghz quad-core"
    end # !> mismatched indentations at 'end' with 'def' at 12

  def get_cpu_price(workstation_id) # ...
    120
  end
  
  def get_mouse_info(workstation_id) # ...
    "Wireless Touch"
  end
  
  def get_mouse_price(workstation_id) # ...
    60
  end
  
  def get_keyboard_info(workstation_id) # ...
    "Standard US"
  end
  
  def get_keyboard_price(workstation_id) # ...
    20
  end

  def get_display_info(workstation_id) # ...
    "LED 1980x1024"
  end

  def get_display_price(workstation_id) # ...
  # ...and so on
    150
  end
end

ds = DS.new
ds.get_cpu_info(42)     # => "2.9 Ghz quad-core"
ds.get_cpu_price(42)    # => 120
ds.get_mouse_info(42)   # => "Wireless Touch"
ds.get_mouse_price(42)  # => 60
