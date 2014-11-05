%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(interact1).
-export([start/1]).

start(Browser) -> running(Browser).

running(Browser) ->
    receive
	{Browser, #{entry => <<"input">>, txt => Bin} }
	    Time = clock1:current_time(),
	    Browser ! #{cmd => append_div, id => scroll, 
	                txt => list_to_binary([Time, " > ", Bin, "<br>"])}
    end,
    running(Browser).

