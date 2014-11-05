%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(nif_test3).

-export([load_lib/0, test/0, alloc/1, set/3, get/2]).
-on_load(load_lib/0).

load_lib() ->
    Z = erlang:load_nif("./nif_test3", 0),
    erlang:display({z,Z}),
    Z.

test() ->
    K = alloc(256),
    set(K, 20, 200),
    J = get(K, 20).
  

alloc(X) ->
      "NIF library not loaded".

set(X, Y, Z) ->
      "NIF library not loaded".

get(X, Y) ->
    "NIF library not loaded".
