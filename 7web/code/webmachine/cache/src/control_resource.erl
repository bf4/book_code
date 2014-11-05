%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(control_resource).
-export([init/1,
         to_html/2,
         expires/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.

expires(ReqData, State) ->
    ReqData2 = wrq:set_resp_header("Cache-Control", "max-age=30", ReqData),
    {undefined, ReqData2, State}.

to_html(ReqData, State) ->
    {"<html><body>Hello, new world</body></html>\n", ReqData, State}.
