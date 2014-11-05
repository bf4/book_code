%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(chat1).
-export([start/1]).

start(Browser) ->
    running(Browser, []).

running(Browser, L) ->
    receive
	{Browser, #{join => Who}} ->
	    Browser ! #{cmd => append_div ,id => scroll, 
		        txt => list_to_binary([Who, " joined the group\n"])},
	    L1 = [Who,"<br>"|L],
	    Browser ! #{cmd => fill_div, id => users,
		        txt => list_to_binary(L1)},
	    running(Browser, L1);
	{Browser,#{entry => <<"tell">>, txt => Txt}} ->
	    Browser ! #{cmd => append_div, id => scroll,
		        txt => list_to_binary([" > ", Txt, "<br>"])},
	    running(Browser, L);
	X ->
	    io:format("chat received:~p~n",[X])
    end,
    running(Browser, L).


