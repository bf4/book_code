-- START:sort_by_time
local function sort_by_time(array)
   table.sort(array, function(e1, e2)
                        return e1.time < e2.time
                     end)
end
-- END:sort_by_time

-- START:schedule
local pending = {}

local function schedule(time, action)
   pending[#pending + 1] = {
      time   = time,
      action = action
   }

   sort_by_time(pending)
end
-- END:schedule

-- START:remove_first
local function remove_first(array)
   result        = array[1]
   array[1]      = array[#array]
   array[#array] = nil

   return result
end
-- END:remove_first

-- START:wait
local function wait(seconds)
   coroutine.yield(seconds)
end
-- END:wait

-- START:run
local function run()
   while #pending > 0 do
      while os.clock() < pending[1].time do end -- busy-wait

      local item = remove_first(pending)
      local _, seconds = coroutine.resume(item.action)

      if seconds then
         later = os.clock() + seconds
         schedule(later, item.action)
      end
   end
end
-- END:run

-- START:module
return {
   schedule = schedule,
   run = run,
   wait = wait
}
-- END:module
