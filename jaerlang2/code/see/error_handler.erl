%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(error_handler).
-export([undefined_function/3,undefined_global_name/2]).
undefined_function(see, F, A) ->
    erlang:display({error_handler,undefined_function,
		    see,F,A}),
    exit(oops);
undefined_function(M, F, A) ->
    erlang:display({new_error_handler,undefined_function,M,F,A}),
    case see:load_module(M) of
	{ok, M} ->
	    case erlang:function_exported(M,F,length(A)) of
		true ->
		    erlang:display({error_handler,calling,M,F,A}),
		    apply(M, F, A);
		false ->
		    see:stop_system({undef,{M,F,A}})
	    end;
	{ok, _Other} ->
	    see:stop_system({undef,{M,F,A}});
	already_loaded ->
	    see:stop_system({undef,{M,F,A}});
	{error, What} ->
	    see:stop_system({load,error,What})
    end.
undefined_global_name(Name, Message) ->
    exit({badarg,{Name,Message}}).
