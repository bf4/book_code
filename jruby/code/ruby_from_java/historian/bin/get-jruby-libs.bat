
REM Excerpted from "Using JRuby",
REM published by The Pragmatic Bookshelf.
REM Copyrights apply to this code. It may not be used to create training material, 
REM courses, books, articles, and the like. Contact us if you are in doubt.
REM We make no guarantees that this code is fit for any purpose. 
REM Visit http://www.pragmaticprogrammer.com/titles/jruby for more book information.

REM This script requires you to have the 'curl' command-line tool installed.
REM You can get it from http://curl.haxx.se.
REM

curl http://jruby.org.s3.amazonaws.com/downloads/1.5.5/jruby-complete-1.5.5.jar -o lib/jruby-complete.jar
IF %ERRORLEVEL% NEQ 0 ECHO "Could not download file; do you have curl installed?"
