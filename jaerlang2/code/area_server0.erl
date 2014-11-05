%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(area_server0).  
-export([loop/0]). 

loop() ->
    receive
	{rectangle, Width, Ht} -> 
	    io:format("Area of rectangle is ~p~n",[Width * Ht]),
	    loop();
	{square, Side} -> 
	    io:format("Area of square is ~p~n", [Side * Side]),
	    loop()
    end.

     

