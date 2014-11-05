%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(shell1).
-export([start/1]).

start(Browser) ->
    Browser ! #{cmd => append_div, id => scroll, 
	        txt => <<"Starting Erlang shell:<br>">>},
    B0 = erl_eval:new_bindings(),
    running(Browser, B0, 1).
running(Browser, B0, N) ->
    receive
	{Browser, #{entry => <<"input">>}, txt => Bin}} ->
	    {Value, B1} = string2value(binary_to_list(Bin), B0),
	    BV = bf("~w > <font color='red'>~s</font><br>~p<br>", 
                    [N, Bin, Value]),
	    Browser ! #{cmd => append_div, id => scroll, txt => BV},
	    running(Browser, B1, N+1)
    end.

string2value(Str, Bindings0) ->
    case erl_scan:string(Str, 0) of
      {ok, Tokens, _} ->
        case erl_parse:parse_exprs(Tokens) of
          {ok, Exprs} -> 
            {value, Val, Bindings1} = erl_eval:exprs(Exprs, Bindings0),
              {Val, Bindings1};
	    Other ->
	      io:format("cannot parse:~p Reason=~p~n",[Tokens,Other]),
		        {parse_error, Bindings0}
	end;
      Other ->
        io:format("cannot tokenise:~p Reason=~p~n",[Str,Other])
    end.

bf(F, D) ->
    list_to_binary(io_lib:format(F, D)).

