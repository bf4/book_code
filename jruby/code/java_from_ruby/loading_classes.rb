#---
# Excerpted from "Using JRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.
#---
require 'java'

java.lang.StringBuffer
# => Java::JavaLang::StringBuffer

require 'clojure.jar'

Java::clojure.lang.Repl
# => Java::ClojureLang::Repl

Java::MyTopLevelClass
# => Java::MyTopLevelClass

swing = javax.swing
swing.JFrame
# => Java::JavaxSwing::JFrame

StringBuffer = java.lang.StringBuffer

java_import java.lang.StringBuffer
java_import 'java.lang.StringBuffer'

require 'jemmy.jar'

['Frame', 'Dialog', 'Button'].each do |name|
  java_import "org.netbeans.jemmy.operators.J#{name}Operator"
end

java_import 'java.lang.String' do |pkg, cls|
  puts "#{cls} lives in #{pkg}"
  'JString' # don't clobber Ruby's String class
end
# >> Using org.netbeans.jemmy.drivers.APIDriverInstaller driver installer
# >> String lives in java.lang
