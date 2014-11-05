#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Numeric
  KILOBYTE = 1024
  MEGABYTE = KILOBYTE * 1024
  GIGABYTE = MEGABYTE * 1024
  TERABYTE = GIGABYTE * 1024
  PETABYTE = TERABYTE * 1024
  EXABYTE  = PETABYTE * 1024

  # Enables the use of byte calculations and declarations, like 45.bytes + 2.6.megabytes
  def bytes
    self
  end
  alias :byte :bytes

  def kilobytes
    self * KILOBYTE
  end
  alias :kilobyte :kilobytes

  def megabytes
    self * MEGABYTE
  end
  alias :megabyte :megabytes

  def gigabytes
    self * GIGABYTE
  end
  alias :gigabyte :gigabytes

  def terabytes
    self * TERABYTE
  end
  alias :terabyte :terabytes

  def petabytes
    self * PETABYTE
  end
  alias :petabyte :petabytes

  def exabytes
    self * EXABYTE
  end
  alias :exabyte :exabytes
end
