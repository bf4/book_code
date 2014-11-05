#---
# Excerpted from "dRuby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/sidruby for more book information.
#---
require 'rinda/ptuplespace'
store = Rinda::TupleStoreLog.new('ts_log')
Rinda::setup_tuple_store(store)

DRb.install_id_conv(Rinda::TupleStoreIdConv.new)
ts = Rinda::PTupleSpace.new
DRb.start_service('druby://localhost:23456', ts)
ts.restore

ts.write(['Hello', 'World'])
p ts.read_all(['Hello', nil])
p ts.take(['Hello', nil])

x = ts.write(['Hello', 'cancel'], 2)
p ts.read_all(['Hello', nil])
ref = DRbObject.new(x)
ref.cancel
p ts.read_all(['Hello', nil])
x = ts.write(['Hello', 'World'])

p DRbObject.new(x)
