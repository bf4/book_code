-- START:part1
module SomeGame where...

type Input = { ... }
type Player = { ... }
type Game = { player:Player, ... }
-- END:part1

-- START:part2
delta = inSeconds <~ fps n

input = sampleOn delta (...)

main = lift display gameState

gameState = foldp stepGame initialGameState input
-- END:part2

-- START:part3
stepGame input game = ...
display (w,h) game = ...
-- END:part3

