#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
module ActiveRecord
  # Allows programmers to programmatically define a schema in a portable
  # DSL. This means you can define tables, indexes, etc. without using SQL
  # directly, so your applications can more easily support multiple
  # databases.
  #
  # Usage:
  #
  #   ActiveRecord::Schema.define do
  #     create_table :authors do |t|
  #       t.string :name, :null => false
  #     end
  #
  #     add_index :authors, :name, :unique
  #
  #     create_table :posts do |t|
  #       t.integer :author_id, :null => false
  #       t.string :subject
  #       t.text :body
  #       t.boolean :private, :default => false
  #     end
  #
  #     add_index :posts, :author_id
  #   end
  #
  # ActiveRecord::Schema is only supported by database adapters that also
  # support migrations, the two features being very similar.
  class Schema < Migration
    private_class_method :new

    # Eval the given block. All methods available to the current connection
    # adapter are available within the block, so you can easily use the
    # database definition DSL to build up your schema (+create_table+,
    # +add_index+, etc.).
    #
    # The +info+ hash is optional, and if given is used to define metadata
    # about the current schema (currently, only the schema's version):
    #
    #   ActiveRecord::Schema.define(:version => 20380119000001) do
    #     ...
    #   end
    def self.define(info={}, &block)
      instance_eval(&block)

      unless info[:version].blank?
        initialize_schema_migrations_table
        assume_migrated_upto_version info[:version]
      end
    end
  end
end
