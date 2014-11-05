#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
ActiveRecord::Schema.define do
  # For sqlite 3.1.0+, make a table with a autoincrement column
  if supports_autoincrement?
    create_table :table_with_autoincrement, :force => true do |t|
      t.column :name, :string
    end
  end

  execute "DROP TABLE fk_test_has_fk" rescue nil
  execute "DROP TABLE fk_test_has_pk" rescue nil
  execute <<_SQL
  CREATE TABLE 'fk_test_has_pk' (
    'id' INTEGER NOT NULL PRIMARY KEY
  );
_SQL

  execute <<_SQL
  CREATE TABLE 'fk_test_has_fk' (
    'id'    INTEGER NOT NULL PRIMARY KEY,
    'fk_id' INTEGER NOT NULL,

    FOREIGN KEY ('fk_id') REFERENCES 'fk_test_has_pk'('id')
  );
_SQL
end