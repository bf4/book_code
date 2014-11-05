%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(geometry1).  
-export([test/0, area/1]). 

test() ->
    12  = area({rectangle, 3, 4}),
    144 = area({square, 12}),
    tests_worked.

area({rectangle, Width, Height}) -> Width * Height;
area({square, Side})             -> Side * Side.
