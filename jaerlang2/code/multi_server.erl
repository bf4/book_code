%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(multi_server).
-export([start/0]).

start() -> spawn(fun() -> multi_server() end).

multi_server() ->
    receive
	{_Pid, {email, _From, _Subject, _Text} = Email} -> %%<label id="multi.email.start"/>
	    {ok, S} = file:open("mbox", [write,append]),
	    io:format(S, "~p.~n", [Email]),
	    file:close(S);                                 %%<label id="multi.email.stop"/>
	{_Pid, {im, From, Text}} ->                        %%<label id="multi.im.start"/>
	    io:format("Msg (~s): ~s~n",[From, Text]);     %%<label id="multi.im.stop"/>
	{Pid, {get, File}} ->                                %%<label id="multi.ftp.start"/>
	    Pid ! {self(), file:read_file(File)};         %%<label id="multi.ftp.stop"/>
	Any ->            %%<label id="multi.rest"/>
	    io:format("multi server got:~p~n",[Any])
    end,
    multi_server().
