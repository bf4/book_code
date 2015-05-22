"START:if
let bees = 32
let mice = 4

if bees < 1
  echo 'I suppose the mice keep the bees out--'
elseif mice < 1
  echo '--or the bees keep the mice out.'
else
  echo 'I don''t know which.'
endif
"END:if

"START:startCaseExample
set ignorecase

let farewell = 'We love you. Ebenezer!'
echo toupper(farewell)                   " → WE LOVE YOU. EBENEZER!
"END:startCaseExample

"START:checkCase
function! CheckCase(normal, upper)
  return a:normal == a:upper ? 'Equal.' : 'Not equal.'
endfunction
"END:checkCase

"START:checkCaseUser
:echo CheckCase(farewell, toupper(farewell))  " → Equal.
"END:checkCaseUser

"START:checkCaseDev
:set noignorecase
:echo CheckCase(farewell, toupper(farewell))  " → Not equal.
"END:checkCaseDev

"START:specificFunctions
" Compares values using ==#
function! CheckCaseSensitive(normal, upper)
  if a:normal ==# a:upper
    return 'Equal (case sensitive).'
  else
    return 'Not equal (case sensitive).'
  endif
endfunction

" Compares values using ==?
function! CheckCaseInsensitive(normal, upper)
  if a:normal ==? a:upper
    return 'Equal (case insensitive).'
  else
    return 'Not equal (case insensitive).'
  endif
endfunction
"END:specificFunctions

"START:checkWithSpecificFunctions
let farewell = 'We love you. Ebenezer!'
let response = 'Will you stop that!'

:echo CheckCaseSensitive(farewell, toupper(farewell))
" → Not equal (case sensitive).

:echo CheckCaseInsensitive(farewell, toupper(farewell))
" → Equal (case insensitive).

:echo CheckCaseInsensitive(farewell, response)
" → Not equal (case insensitive).
"END:checkWithSpecificFunctions
