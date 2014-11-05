function Monster(t)
   return t
end

function Vehicle(t)
   return t
end

-- START:simple
Monster{
   name   = "rat",
   width  = 1,
   height = 1
}

Monster{
   name   = "snake",
   width  = 1,
   height = 15
}
-- END:simple

-- START:attr
Monster{
   name     = "knight",
   treasure = {-1000, 200}
}

local cube_size = 20

Vehicle{
   name     = "mine cart",
   width    = cube_size,
   height   = cube_size
}
-- END:attr

-- START:func
Monster{
   name  = "cobra",
   speed = function() return 10 * damage_to_player() end
}
-- END:func
