%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(cgi_web_server).
-compile(export_all).

start() ->
    start(12345).

start_from_shell([PortAsAtom]) ->
    PortAsInt = list_to_integer(atom_to_list(PortAsAtom)),
    start(PortAsInt).
%%

start(Port) ->
    ok = application:start(crypto),
    ok = application:start(ranch),  
    ok = application:start(cowboy),
    N_acceptors = 100,
    Dispatch = cowboy_router:compile(
		 [
		  %% {URIHost, list({URIPath, Handler, Opts})}
		  {'_', [{'_', cgi_web_server, []}]}
		 ]),
    cowboy:start_http(cgi_web_server,
		      N_acceptors,
		      [{port, Port}],
		      [{env, [{dispatch, Dispatch}]}]
		     ).

init({tcp, http}, Req, _Opts) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {Path, Req1} = cowboy_req:path(Req),
    handle1(Path, Req1, State).
handle1(<<"/cgi">>, Req, State) ->
    {Args, Req1} = cowboy_req:qs_vals(Req),
    {ok, Bin, Req2} = cowboy_req:body(Req1),
    Val = mochijson2:decode(Bin),
    Response = call(Args, Val),
    Json = mochijson2:encode(Response),
    {ok, Req3} = cowboy_req:reply(200, [], Json, Req2),
    {ok, Req3, State};
handle1(Path, Req, State) ->
    Response = read_file(Path),
    {ok, Req1} = cowboy_req:reply(200, [], Response, Req),
    {ok, Req1, State}.

terminate(_Reason, _Req, _State) ->
    ok.

call([{<<"mod">>,MB},{<<"func">>,FB}], X) ->
    Mod = list_to_atom(binary_to_list(MB)),
    Func = list_to_atom(binary_to_list(FB)),
    apply(Mod, Func, [X]).

read_file(Path) ->
    File = [$.|binary_to_list(Path)],
    case file:read_file(File) of
	{ok, Bin} -> Bin;
	_ -> ["<pre>cannot read:", File, "</pre>"]
    end.

	    
