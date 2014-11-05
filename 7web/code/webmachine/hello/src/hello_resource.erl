%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(hello_resource).
-export([init/1, to_html/2]). %% (1)
-include_lib("webmachine/include/webmachine.hrl"). %% (2)

init([]) -> {ok, undefined}. %% (3)

to_html(ReqData, State) -> %% (4)
    {"<html><body>Hello, new world</body></html>", ReqData, State}.
