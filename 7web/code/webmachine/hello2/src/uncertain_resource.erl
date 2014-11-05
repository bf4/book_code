%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(uncertain_resource).
-export([init/1,
         to_html/2]).

-export([resource_exists/2,
         previously_existed/2,
         moved_permanently/2]).

-include_lib("webmachine/include/webmachine.hrl").
init([]) -> {ok, undefined}.
to_html(ReqData, State) ->
    {"nothing to see here", ReqData, State}.

%% remember to add resource_exists/2 to the export list

resource_exists(ReqData, State) ->
    {false, ReqData, State}.

%% remember to add previously_existed/2 to the export list

previously_existed(ReqData, State) ->
    {true, ReqData, State}.

%% remember to add moved_permanently/2 to the export list

moved_permanently(ReqData, State) ->
    {{true, "http://pragprog.com/"}, ReqData, State}.
