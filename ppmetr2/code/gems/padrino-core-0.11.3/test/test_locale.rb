#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require File.expand_path(File.dirname(__FILE__) + '/helper')

describe "Locales" do
  Dir[File.expand_path("../../lib/padrino-core/locale/*.yml", __FILE__)].each do |file|
    base_original = YAML.load_file(file)
    name = File.basename(file, '.yml')
    should "should have correct locale for #{name}" do
      base = base_original[name]['date']['formats']
      assert base['default'].present?
      assert base['short'].present?
      assert base['long'].present?
      assert base['only_day'].present?
      base = base_original[name]['date']
      assert base['day_names'].present?
      assert base['abbr_day_names'].present?
      assert base['month_names'].present?
      assert base['abbr_month_names'].present?
      assert base['order'].present?
    end
  end
end
