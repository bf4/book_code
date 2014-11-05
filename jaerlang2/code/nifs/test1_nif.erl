%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(test1_nif).

-export([load_lib/0, addem/2]).
-on_load(load_lib/0).

load_lib() ->
    erlang:load_nif("./test1_nif", 0).

addem(_,_) ->
      "NIF library not loaded".
