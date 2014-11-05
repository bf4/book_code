rl = require('readline').createInterface
  input: process.stdin
  output: process.stdout

rl.question "To whom am I speaking? ", (audience) ->
  console.log("Hello, #{audience}!")
