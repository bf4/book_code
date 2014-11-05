%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(auth_never_resource).
-export([init/1,
         is_authorized/2,
         to_html/2]).
-include_lib("webmachine/include/webmachine.hrl").
init([]) -> {ok, undefined}.

is_authorized(ReqData, State) ->
    {"Basic realm=testing", ReqData, State}.

to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>\n", ReqData, State}.
