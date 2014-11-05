%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(hello_verbose_resource).
-export([init/1,
         content_types_provided/2,
         to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

content_types_provided(ReqData, State) ->
    {[{"text/html", to_html}], ReqData, State}.

to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>", ReqData, State}.
