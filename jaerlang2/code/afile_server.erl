%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(afile_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(afile_server, loop, [Dir]).

loop(Dir) ->
    receive
	{Client, list_dir} ->
	    Client ! {self(), file:list_dir(Dir)};
	{Client, {get_file, File}} ->
	    Full = filename:join(Dir, File),
	    Client ! {self(), file:read_file(Full)}
    end,
    loop(Dir).

	


		    
