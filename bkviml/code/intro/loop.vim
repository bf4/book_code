"START:while
let animalKingdom = ['Crocodile', 'Bug', 'Octopus', 'Penguin']

while len(animalKingdom) > 0
  "START:list
  echo animalKingdom[0] . ' Friend'
  call remove(animalKingdom, 0)
  "END:list
endwhile

" → Crocodile Friend
"   Bug Friend
"   Octopus Friend
"   Penguin Friend
"END:while

"START:for
let scientists = ['Robert Whate', 'Bill Cook', 'Brad Noggin', 'Squirt']

for scientist in scientists
  echo 'Dr. ' . scientist
endfor

" → Dr. Robert Whate
"   Dr. Bill Cook
"   Dr. Brad Noggin
"   Dr. Squirt
"END:for
