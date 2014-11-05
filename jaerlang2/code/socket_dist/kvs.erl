%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(kvs).
-export([start/0, store/2, lookup/1]).

start() -> register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) -> rpc({store, Key, Value}). %%<label id="kvs.store1"/>

lookup(Key) -> rpc({lookup, Key}). %%<label id="kvs.lookup1"/>

rpc(Q) ->
    kvs ! {self(), Q},
    receive
	{kvs, Reply} ->
	    Reply
    end.

loop() ->  %%<label id="kvs.loop"/>
    receive
	{From, {store, Key, Value}} ->  %%<label id="kvs.store2"/>
	    put(Key, {ok, Value}),
	    From ! {kvs, true},
	    loop();
	{From, {lookup, Key}} -> %%<label id="kvs.lookup2"/>
	    From ! {kvs, get(Key)},
	    loop()
    end.
