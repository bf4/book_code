function call_twice(f)
   ff = function(num)
           return f(f(num))
   end

   return ff
end

function triple(n)
   return n * 3
end

times_nine = call_twice(triple)

print(times_nine(5))
