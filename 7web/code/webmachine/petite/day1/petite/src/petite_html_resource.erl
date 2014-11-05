%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(petite_html_resource).

-export([init/1,
         to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) ->
    {ok, dict:new()}.

to_html(ReqData, State) ->
    Ctx = dict:store(url, "http://metajack.im", wrq:path_info(ReqData)),
    Resp = mustache:render("<html><body>url is {{url}}</body></html>", Ctx),
    {Resp, ReqData, State}.
