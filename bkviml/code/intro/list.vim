"START:listExamples
let animalKingdom = ['Crocodile', 'Lizard', 'Bug', 'Squid']
echo animalKingdom
" → ['Crocodile', 'Lizard', 'Bug', 'Squid']

call add(animalKingdom, 'Penguin')
echo animalKingdom
" → ['Crocodile', 'Lizard', 'Bug', 'Squid', 'Penguin']

call remove(animalKingdom, 3)
call insert(animalKingdom, 'Octopus', 3)
echo animalKingdom[3]
" → Octopus

echo animalKingdom
" → ['Crocodile', 'Lizard', 'Bug', 'Octopus', 'Penguin']
"END:listExamples

"START:listNotCopied
let animalKingdom = ['Crocodile', 'Lizard', 'Bug', 'Octopus', 'Penguin']
echo animalKingdom
" → ['Crocodile', 'Lizard', 'Bug', 'Octopus', 'Penguin']

echo sort(animalKingdom)
" → ['Bug', 'Crocodile', 'Lizard', 'Octopus', 'Penguin']

echo animalKingdom
" → ['Bug', 'Crocodile', 'Lizard', 'Octopus', 'Penguin']
"END:listNotCopied

"START:listCopy
echo sort(copy(animalKingdom))
" → ['Bug', 'Crocodile', 'Lizard', 'Octopus', 'Penguin']

echo animalKingdom
" → ['Crocodile', 'Lizard', 'Bug', 'Octopus', 'Penguin']
"END:listCopy

"START:listToString
echo string(animalKingdom)
"END:listToString
"
"START:listSlice
let animalKingdom = ['Frog', 'Rat', 'Crocodile', 'Lizard', 'Bug', 'Octopus', 
                   \ 'Penguin']
let forest = animalKingdom[0:2]

echo forest
" → ['Frog', 'Rat', 'Crocodile']
"END:listSlice

"START:listNoStartSlice
let forest = animalKingdom[:2]
"END:listNoStartSlice

"START:listEndSlice
let animalKingdom = ['Frog', 'Rat', 'Crocodile', 'Lizard', 'Bug', 'Octopus',
                   \ 'Penguin']
echo animalKingdom[2:-1]
" → ['Crocodile', 'Lizard', 'Bug', 'Octopus', 'Penguin']
"END:listEndSlice
