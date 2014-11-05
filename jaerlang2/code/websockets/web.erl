%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(web).
-compile(export_all).

main(Args) ->
    Zip = escript:script_name(),
    io:format("Args:~p~n",[Zip]),
    {ok, Bin} = file:read_file(Zip),
    Bin1 = find_start(Bin),
    F = fun(A,B,C,D) ->
		case cache(A) of
		    true ->
			[{A,C()}|D];
		    false ->
			D
		end
	end,
    {ok, Cache} = zip:foldl(F, [], {Zip, Bin1}),
    Names = [N || {N,_} <- Cache],
    io:format("Cached:~p~n",[Names]),
    websockets:start_embedded(2234),
    init:stop().

find_start(<<$P,$K,_/binary>> = Bin) ->
    Bin;
find_start(<<X:8,B/binary>>) ->
    find_start(B).

cache(F) ->
    lists:member(filename:extension(F),
		 [".html", ".css", ".js"]).

    

