#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'
require 'jruby/core_ext'

java_import 'PerformedBy'
java_import 'Chronicler'
java_import 'Sorcery'

class Mischief
  # ... more mischief here ...
end

Mischief.add_class_annotation PerformedBy => {'name' => 'Ian'}
Mischief.become_java!

Chronicler.describe Sorcery
# >>> Charlie performs Sorcery

Chronicler.describe Mischief
# >>> Ian performs ruby.Mischief
