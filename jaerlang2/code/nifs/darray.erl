%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(darray).

-export([load_lib/0, test/0, make_array/1, set_element/3, get_element/2]).
-on_load(load_lib/0).

load_lib() ->
    erlang:load_nif("./darray", 0).

test() ->
    spawn(fun() -> test1() end).

test1() ->
    K = make_array(256),
    set_element(K, 20, 200),
    200 = get_element(K, 20),
    set_element(K, 20, 201),
    201 = get_element(K, 20),
    io:format("test worked~n").  

make_array(_) -> "NIF library not loaded".

set_element(_, _, _) -> "NIF library not loaded".

get_element(_, _) -> "NIF library not loaded".
