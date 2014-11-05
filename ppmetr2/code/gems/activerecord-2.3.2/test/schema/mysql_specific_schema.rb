#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
ActiveRecord::Schema.define do
  create_table :binary_fields, :force => true, :options => 'CHARACTER SET latin1' do |t|
    t.binary :tiny_blob,   :limit => 255
    t.binary :normal_blob, :limit => 65535
    t.binary :medium_blob, :limit => 16777215
    t.binary :long_blob,   :limit => 2147483647
    t.text   :tiny_text,   :limit => 255
    t.text   :normal_text, :limit => 65535
    t.text   :medium_text, :limit => 16777215
    t.text   :long_text,   :limit => 2147483647
  end
end
