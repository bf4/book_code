"START:funcref
let Example = function('EchoQuote')
call Example()
"END:funcref

"START:funcrefWithArguments
function! EchoQuote(quote, ...)
  let year = a:1
  let author = a:000[1]
  return 'In ' . year . ', ' . author . ' said: "' . a:quote . '"'
endfunction

let Example = function('EchoQuote')
let q = 'This crocodile mouth is the perfect helmet all the family will enjoy.'

echo call(Example, [q, '2014', 'Dr. Carl Grommy'])
"END:funcrefWithArguments

"START:funcrefToString
echo string(Example)
"END:funcrefToString
