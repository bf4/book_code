-- START:basic
dietrich = {
   name     = "Dietrich",
   health   = 100,

   take_hit = function(self)
      self.health = self.health - 10
   end
}
-- END:basic

-- START:copy
clone = {
   name     = dietrich.name,
   health   = dietrich.health,
   take_hit = dietrich.take_hit
}
-- END:copy

-- START:copy_read
print(clone.health) --> 100
-- END:copy_read

-- START:basic

dietrich.take_hit(dietrich)
print(dietrich.health)     --> 90
-- END:basic

-- START:ctor
Villain = {
   health = 100,

   new = function(self, name)
      local obj = {
         name   = name,
         health = self.health,
      }

      return obj
   end,

   take_hit = function(self)
      self.health = self.health - 10
   end
}

dietrich = Villain.new(Villain, "Dietrich")
-- END:ctor

-- START:take_hit
Villain.take_hit(dietrich)  --> ok
-- END:take_hit
--[[
-- START:take_hit
dietrich.take_hit(dietrich) --> error: attempt to call field
                            --> 'take_hit' (a nil value)
-- END:take_hit
--]]

Villain = {
   health = 100,

   -- START:meta
   new = function(self, name)
      local obj = {
         name   = name,
         health = self.health,
      }

      setmetatable(obj, self)
      self.__index = self

      return obj
   end,
   -- END:meta

   take_hit = function(self)
      self.health = self.health - 10
   end
}

-- START:use_meta
dietrich = Villain.new(Villain, "Dietrich")
dietrich.take_hit(dietrich) --> ok
-- END:use_meta

-- START:inherit
SuperVillain = Villain.new(Villain)

function SuperVillain.take_hit(self)
   -- Haha, armor!
   self.health = self.health - 5
end

toht = SuperVillain.new(SuperVillain, "Toht")
toht.take_hit(toht)
print(toht.health) --> 95
-- END:inherit

-- START:sugar
Villain = { health = 100 }

function Villain:new(name)
   -- ...same implementation as before...
   -- END:sugar
   local obj = {
      name   = name,
      health = self.health,
   }

   setmetatable(obj, self)
   self.__index = self

   return obj
   -- START:sugar
end

function Villain:take_hit()
   -- ...same implementation as before...
   -- END:sugar
   self.health = self.health - 10
   -- START:sugar
end
-- END:sugar

-- START:sugar

SuperVillain = Villain:new()

function SuperVillain:take_hit()
   -- ...same implementation as before...
   -- END:sugar
   -- Haha, armor!
   self.health = self.health - 5
   -- START:sugar
end
-- END:sugar

-- START:use_sugar
dietrich = Villain:new("Dietrich")
dietrich:take_hit()
print(dietrich.health) --> 90

toht = SuperVillain:new("Toht")
toht:take_hit()
print(toht.health)     --> 95
-- END:use_sugar
