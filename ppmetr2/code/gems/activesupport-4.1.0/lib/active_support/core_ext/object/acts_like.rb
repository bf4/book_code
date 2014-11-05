#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  # A duck-type assistant method. For example, Active Support extends Date
  # to define an <tt>acts_like_date?</tt> method, and extends Time to define
  # <tt>acts_like_time?</tt>. As a result, we can do <tt>x.acts_like?(:time)</tt> and
  # <tt>x.acts_like?(:date)</tt> to do duck-type-safe comparisons, since classes that
  # we want to act like Time simply need to define an <tt>acts_like_time?</tt> method.
  def acts_like?(duck)
    respond_to? :"acts_like_#{duck}?"
  end
end
