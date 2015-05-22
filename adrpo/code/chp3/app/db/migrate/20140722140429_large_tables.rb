#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
class LargeTables < ActiveRecord::Migration
  def up
    create_table :things do |t|
      10.times do |i|
        t.string "col#{i}"
      end
    end

    execute <<-END
      insert into things(col0, col1, col2, col3, col4,
                         col5, col6, col7, col8, col9) (
        select
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x')
        from generate_series(1, 10000)
      );
    END
  end
  def down
    drop_table :things
  end
end
