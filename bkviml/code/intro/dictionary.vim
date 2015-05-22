"START:dictionary
let scientists = {'Retxab': 'Alfred Clark', 'Nielk': 'Bill von Cook'}

echo scientists['Retxab']            " → Alfred Clark
"END:dictionary

"START:dictionaryValues
let scientists = {'Retxab': {'Clark': 'Alfred', 'Stoner': 'Fred', 'Noggin': 'Brad'},
      \ 'Nielk': {'Whate': 'Robert', 'von Cook': 'Bill'}}

echo scientists['Retxab']['Stoner']  " → Fred
"END:dictionaryValues

"START:addEntry
let scientists['Trhok'] = 'Squirt'
echo scientists.Trhok                " → Squirt
"END:addEntry
