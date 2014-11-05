#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Contact < ActiveRecord::Base
  # mock out self.columns so no pesky db is needed for these tests
  def self.column(name, sql_type = nil, options = {})
    @columns ||= []
    @columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, options[:default], sql_type.to_s, options[:null])
  end

  column :name,        :string
  column :age,         :integer
  column :avatar,      :binary
  column :created_at,  :datetime
  column :awesome,     :boolean
  column :preferences, :string

  serialize :preferences
end