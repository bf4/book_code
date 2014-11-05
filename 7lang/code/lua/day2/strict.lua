-- START:strict_read
local _private = {}

function strict_read(table, key)
   if _private[key] then
      return _private[key]
   else
      error("Invalid key: " .. key)
   end
end
-- END:strict_read

-- START:strict_write
function strict_write(table, key, value)
   if _private[key] then
      error("Duplicate key: " .. key)
   else
      _private[key] = value
   end
end
-- END:strict_write

-- This version can delete keys
function strict_write(table, key, value)
   if _private[key] and value then
      error("Duplicate key: " .. key)
   else
      _private[key] = value
   end
end

-- START:metatable
local mt = {
   __index    = strict_read,
   __newindex = strict_write
}

treasure = {}
setmetatable(treasure, mt)
-- END:metatable

treasure.gold = 50
print(treasure.gold) --> 50
-- print(treasure.silver) --> error
-- treasure.gold = 100 --> error

treasure.gold = nil
