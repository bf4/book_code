%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(simple_web_server).
-compile(export_all).

start() ->
    start(8877).

start(Port) ->
    ok = application:start(crypto), %%<label id="web.app.start"/>
    ok = application:start(ranch),  
    ok = application:start(cowboy), %%<label id="web.app.end"/>
    N_acceptors = 10, %%<label id="web.app.acc"/>
    Dispatch = cowboy_router:compile(
		 [
		  %% {URIHost, list({URIPath, Handler, Opts})}
		  {'_', [{'_', simple_web_server, []}]}  %%<label id="web.app.disp"/>
		 ]),
    cowboy:start_http(my_simple_web_server,
		      N_acceptors,       %%<label id="web.app.accu"/>
		      [{port, Port}],
		      [{env, [{dispatch, Dispatch}]}]
		     ).


init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined}.
handle(Req, State) ->
    {Path, Req1} = cowboy_req:path(Req),                %%<label id="web.handle1"/>
    Response = read_file(Path),                             %%<label id="web.handle2"/>
    {ok, Req2} = cowboy_req:reply(200, [], Response, Req1), %%<label id="web.handle3"/>
    {ok, Req2, State}.  %%<label id="web.handle4"/>
terminate(_Reason, _Req, _State) ->
    ok.

read_file(Path) ->
    File = ["."|binary_to_list(Path)],
    case file:read_file(File) of
	{ok, Bin} -> Bin;
	_ -> ["<pre>cannot read:", File, "</pre>"]
    end.
