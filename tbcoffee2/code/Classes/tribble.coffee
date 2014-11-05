class Tribble
  constructor: ->
    @isAlive = true
    Tribble.count += 1

  # Prototype properties
  breed: -> new Tribble if @isAlive
  die: ->
    return unless @isAlive
    Tribble.count -= 1
    @isAlive = false

  # Class-level properties
  @count: 0
  @makeTrouble: -> console.log ('Trouble!' for i in [1..@count]).join(' ')

tribble1 = new Tribble
tribble2 = new Tribble
Tribble.makeTrouble()   # "Trouble! Trouble!"

tribble1.die()
Tribble.makeTrouble()   # "Trouble!"

tribble2.breed().breed().breed()
Tribble.makeTrouble()   # "Trouble! Trouble! Trouble! Trouble!"
