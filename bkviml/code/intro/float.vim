"START:float
let flotation = 96.7
"END:float

"START:floatConversion
let no = 42 + 96.7
echo no         " → 138.7 
echo type(no)   " → 5
"END:floatConversion

"START:compareType
echo type(no) == type(1.5)           " → 1
"END:compareType

"START:compareOtherTypes
let no = 12.5
echo type(no) == type("warysammy")   " → 0
"END:compareOtherTypes
