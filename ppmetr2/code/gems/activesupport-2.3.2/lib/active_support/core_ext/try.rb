#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Object
  # Invokes the method identified by the symbol +method+, passing it any arguments 
  # and/or the block specified, just like the regular Ruby <tt>Object#send</tt> does.
  #
  # *Unlike* that method however, a +NoMethodError+ exception will *not* be raised 
  # and +nil+ will be returned instead, if the receiving object is a +nil+ object or NilClass.
  #
  # ==== Examples
  #
  # Without try
  #   @person && @person.name
  # or
  #   @person ? @person.name : nil
  #
  # With try
  #   @person.try(:name)
  #
  # +try+ also accepts arguments and/or a block, for the method it is trying
  #   Person.try(:find, 1)
  #   @people.try(:collect) {|p| p.name}
  #--
  # This method definition below is for rdoc purposes only. The alias_method call 
  # below overrides it as an optimization since +try+ behaves like +Object#send+,
  # unless called on +NilClass+.
  def try(method, *args, &block)
    send(method, *args, &block)
  end
  remove_method :try
  alias_method :try, :__send__
end

class NilClass
  def try(*args)
    nil
  end
end
