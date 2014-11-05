function retry(count, body)
   for i = 1, count do
      local co = coroutine.create(
         function()
            body()
         end
      )

      local succeeded, exception = coroutine.resume(co)
      if succeeded and not exception then return end
      print('Error: ' .. exception .. '; retrying')
   end

   print('Gave up retrying')
end

math.randomseed(os.time())

retry(
   5,

   function()
      if math.random() > 0.2 then
         coroutine.yield('Something bad happened')
      end

      print('Succeeded')
   end
)
