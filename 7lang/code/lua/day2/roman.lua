function roman_numeral(s)
   local values = {
      i = 1,
      v = 5,
      x = 10
   }

   local result   = 0
   local previous = 0

   for c in string.gmatch(s, '.') do
      local current = values[c]

      result = result + current
      if current > previous then
         result = result - 2 * previous
      end

      previous = current
   end

   return result
end

mt = {
   __index = function(_, s)
      return roman_numeral(s)
   end
}

roman = {}
setmetatable(roman, mt)

print(roman.xiv)

