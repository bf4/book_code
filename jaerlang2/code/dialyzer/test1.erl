%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(test1).
-export([f1/0]).

f1() -> 
    X = erlang:time(),
    seconds(X).

seconds({_Year, _Month, _Day, Hour, Min, Sec}) ->
    (Hour * 60 + Min)*60 + Sec.
