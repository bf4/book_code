%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(see_test3).
-export([main/0]).
-import(see, [read/0, write/1]).

main() -> loop().

loop() ->
    case read() of
        eof ->
            true;
        {ok, X} ->
            write([X]),
            loop()
    end.
