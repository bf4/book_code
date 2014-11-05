-- START:print_table
function print_table(t)
   for k, v in pairs(t) do
      print(k .. ": " .. v)
   end
end
-- END:print_table

-- START:table_to_string
function table_to_string(t)
   local result = {}

   for k, v in pairs(t) do
      result[#result + 1] = k .. ": " .. v
   end

   return table.concat(result, "\n")
end
-- END:table_to_string
