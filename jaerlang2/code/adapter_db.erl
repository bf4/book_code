%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(adapter_db).
-export([test/0, make/1, store/3, lookup/2]).

test() ->
    %% test the dict module
    M0 = make(dict),
    M1 = M0:store(key1, val1),
    M2 = M1:store(key2, val2),
    {ok, val1} = M2:lookup(key1),
    {ok, val2} = M2:lookup(key2),
    error = M2:lookup(nokey),
    %% test the lists module
    N0 = make(lists),
    N1 = N0:store(key1, val1),
    N2 = N1:store(key2, val2),
    {ok, val1} = N2:lookup(key1),
    {ok, val2} = N2:lookup(key2),
    error = N2:lookup(nokey),
    ok.

make(dict) -> 
    {?MODULE, dict, dict:new()};
make(lists) ->
    {?MODULE, lists, []}.

store(Key, Val, {?MODULE, dict, D}) ->
    D1 = dict:store(Key, Val, D),
    {?MODULE, dict, D1};
store(Key, Val, {?MODULE, lists, L}) ->
    {?MODULE, lists, lists:keystore(Key, 1, L, {Key,Val})}.

lookup(Key, {?MODULE, dict, D}) ->
    dict:find(Key, D);	    
lookup(Key, {?MODULE, lists, L}) ->
    case lists:keysearch(Key, 1, L) of
	{value, {Key,Val}} ->
	    {ok, Val};
	false ->
	    error
    end.

