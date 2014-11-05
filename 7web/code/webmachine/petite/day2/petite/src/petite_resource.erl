%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
%% @doc Example webmachine_resource.

-module(petite_resource).
-export([init/1, 
         to_html/2,
         allowed_methods/2,
         resource_exists/2,
         previously_existed/2,
         moved_permanently/2]).



-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

allowed_methods(ReqData, Context) ->
    {['GET'], ReqData, Context}.

resource_exists(ReqData, Context) ->
    {false, ReqData, Context}.

previously_existed(ReqData, Context) ->
    {true, ReqData, Context}.

moved_permanently(ReqData, Context) ->
    {{true, "http://metajack.im/"}, ReqData, Context}.

to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>", ReqData, State}.
