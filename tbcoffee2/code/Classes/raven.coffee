Raven = ->
Raven::quoth = -> console.log 'Nevermore'
raven1 = new Raven
raven1.quoth()    # Nevermore

Raven::quoth = -> console.log "I'm hungry"
raven1.quoth()    # I'm hungry

raven2 = new Raven
raven2.quoth = -> console.log "I'm my own kind of raven"
raven1.quoth()    # I'm hungry
raven2.quoth()    # I'm my own kind of raven

console.log raven1.hasOwnProperty('quoth')  # false
console.log raven2.hasOwnProperty('quoth')  # true

raven3 = new Raven
console.log raven3.hasOwnProperty('quoth')  # false
raven3.quoth = raven3.quoth
console.log raven3.hasOwnProperty('quoth')  # true
