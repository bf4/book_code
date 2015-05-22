"START:echoQuote
function! EchoQuote()
  echo 'A poet can but ill spare time for prose.'
endfunction
command Quote   call EchoQuote()
"END:echoQuote

"START:callEchoQuoteCommand
:Quote
"END:callEchoQuoteCommand

"START:echoQuoteWithArgument
function! EchoQuote(quote)
  echo a:quote
endfunction
"END:echoQuoteWithArgument

"START:echoQuoteCommandWithNoArgument
command -nargs=0 Quote   call EchoQuote()
"END:echoQuoteCommandWithNoArgument

"START:echoQuoteCommandWithArgument
command -nargs=1 Quote   call EchoQuote(<args>)
"END:echoQuoteCommandWithArgument

"START:callEchoQuoteCommandWithArgument
:Quote "I write, and you send me a fish."
" → I write, and you send me a fish.
"END:callEchoQuoteCommandWithArgument

"START:ifExistsCommand
if(!exists(":PlaySelectedSong")
  command PlaySelectedSong call mpc#PlaySong(line("."))
endif
"END:ifExistsCommand
