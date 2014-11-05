%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(unit_test).
-export([start/0]).

start() ->
    io:format("Testing drivers~n"),
    example1:start(),
    6 = example1:twice(3),
    10 = example1:sum(6,4),
    example1_lid:start(),
    8 = example1_lid:twice(4),
    20 = example1_lid:sum(15,5),
    io:format("All tests worked~n"),
    init:stop().
