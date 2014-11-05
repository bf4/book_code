%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(bertie).
-export([start/0]).
      
start() ->
    Handle = bitcask:open("bertie_database", [read_write]),
    N = fetch(Handle),
    store(Handle, N+1),
    io:format("Bertie has been run ~p times~n",[N]),
    bitcask:close(Handle),
    init:stop().

store(Handle, N) ->
    bitcask:put(Handle, <<"bertie_executions">>, term_to_binary(N)).  
fetch(Handle) ->
    case bitcask:get(Handle, <<"bertie_executions">>) of
	not_found -> 1;
	{ok, Bin} -> binary_to_term(Bin)
    end.
