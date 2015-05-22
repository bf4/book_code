"START:first
"START:firstFirstLine
function! EchoQuote()
"END:firstFirstLine
  echo 'A poet can but ill spare time for prose.'
endfunction
"END:first

"START:second
function! EchoQuote()
  let quote = 'A poet can but ill spare time for prose.'
  echo quote
endfunction
"END:second

"START:third
function! EchoQuote(quote)
  echo a:quote
endfunction
call EchoQuote('A poet can but ill spare time for prose.')

" → A poet can but ill spare time for prose.
"END:third

"START:fourth
function! EchoQuote(quote, ...)
  let year = a:1
  let author = a:000[1]
  echo 'In ' . year . ', ' . author . ' said: "' . a:quote . '"'
endfunction

call EchoQuote('A poet can but ill spare time for prose.',
            \ '1784', 'William Cowper')

" → In 1784, William Cowper said: "A poet can but ill spare time for prose."
"END:fourth
