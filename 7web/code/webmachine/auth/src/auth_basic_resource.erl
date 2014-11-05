%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(auth_basic_resource).
-export([init/1,
         is_authorized/2,
         to_html/2]).
		 
-include_lib("webmachine/include/webmachine.hrl").
init([]) -> {ok, undefined}.
is_authorized(ReqData, State) ->
    AuthHead = "Basic realm=Identify yourself!",
    Result = case wrq:get_req_header("authorization", ReqData) of %% (1)
                 "Basic " ++ EncodedAuthStr ->
                     AuthStr = base64:decode_to_string(EncodedAuthStr), %% (2)
                     [User, Pass] = string:tokens(AuthStr, ":"),
                     case authorized(User, Pass) of %% (3)
                         true ->
                             true;
                         false ->
                             AuthHead
                     end;
                 _ ->
                     AuthHead
             end,
    {Result, ReqData, State}.

authorized(User, Pass) -> %% (4)
    User =:= "test" andalso Pass =:= "12345".

to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>\n", ReqData, State}.
