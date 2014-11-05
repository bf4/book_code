%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(clock).
-export([start/2, stop/0]).

start(Time, Fun) -> 
    register(clock, spawn(fun() -> tick(Time, Fun) end)).
stop() -> clock ! stop.
tick(Time, Fun) ->
    receive
	stop ->
	    void
    after Time ->
	    Fun(),
	    tick(Time, Fun)
    end.
