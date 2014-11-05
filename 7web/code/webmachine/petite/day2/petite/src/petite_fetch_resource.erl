%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(petite_fetch_resource).
-export([init/1, 
         to_html/2,
         resource_exists/2,
         previously_existed/2,
         moved_permanently/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) ->
    {ok, ""}.

to_html(ReqData, State) ->
    {"", ReqData, State}.

resource_exists(ReqData, State) ->
    {false, ReqData, State}.

previously_existed(ReqData, State) ->
    Code = wrq:path_info(code, ReqData),
    case petite_url_srv:get_url(Code) of
        {ok, Url} ->
            {true, ReqData, Url};
        {error, not_found} ->
            {false, ReqData, State}
    end.

moved_permanently(ReqData, State) ->
    {{true, State}, ReqData, State}.
