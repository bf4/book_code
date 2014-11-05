%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(types1).
-export([f1/1, f2/1, f3/1]).

f1({H,M,S}) ->
    (H+M*60)*60+S.

f2({H,M,S}) when is_integer(H) ->
    (H+M*60)*60+S.

f3({H,M,S}) ->
    print(H,M,S),
    (H+M*60)*60+S.

print(H,M,S) ->
    Str = integer_to_list(H) ++ ":" ++ integer_to_list(M) ++ ":" ++
	integer_to_list(S),
    io:format("~s", [Str]).
