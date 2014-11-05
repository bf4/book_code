%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(svg1).
-export([start/1]).

start(Browser) ->
    Browser ! #{cmd => add_canvas, tag => svg, width => 180, height => 120},
    running(Browser, 10, 10).

running(Browser, X, Y) ->
    receive
	{Browser,#{clicked => <<"draw rectangle">>}} ->
	    Browser ! #{cmd => add_svg_thing, type => rect,
		        rx => 3, ry => 3, x => X, y => Y, 
                        width => 100,height => 50,
		        stroke => blue,'stroke-width' => 2,
                        fill =>  red},
	    running(Browser, X+10, Y+10)
    end.
