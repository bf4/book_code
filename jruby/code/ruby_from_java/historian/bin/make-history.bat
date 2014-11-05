
REM Excerpted from "Using JRuby",
REM published by The Pragmatic Bookshelf.
REM Copyrights apply to this code. It may not be used to create training material, 
REM courses, books, articles, and the like. Contact us if you are in doubt.
REM We make no guarantees that this code is fit for any purpose. 
REM Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.

git init
echo Read > README.txt
git add README.txt
git commit -m One
echo Me >> README.txt
git commit -am Two
echo First >> README.txt
git commit -am Three
