%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(petite_latest_resource).
-export([init/1, to_html/2]).

-export([content_types_provided/2, to_text/2, to_json/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) ->
    {ok, undefined}.

to_html(ReqData, State) ->
    {ok, TemplateBin} = file:read_file(
                          code:priv_dir(petite) ++ "/latest.html.mustache"),
    TemplateStr = binary_to_list(TemplateBin),
    
    Host = wrq:get_req_header("host", ReqData),
    BaseUrl = "http://" ++ Host ++ "/",

    {ok, LatestLinks} = petite_url_srv:get_latest(20),
    LatestDicts = [dict:from_list([{short_link, BaseUrl ++ ShortLink},
                                   {long_link, LongLink}]) 
                   || {ShortLink, LongLink} <- LatestLinks],
    Context = dict:from_list([{links, LatestDicts}]),

    Response = mustache:render(TemplateStr, Context),
    {Response, ReqData, State}.


content_types_provided(ReqData, State) ->
    {[{"text/html", to_html},
      {"text/plain", to_text},
      {"application/json", to_json}], ReqData, State}.
to_text(ReqData, State) ->
    {ok, LatestLinks} = petite_url_srv:get_latest(20),
    Result = lists:map(
               fun({Code, Link}) ->
                       [base_url(ReqData), Code, " ", Link, "\n"] %% (1)
               end,
               LatestLinks),
    {Result, ReqData, State}.
base_url(ReqData) -> %% (2)
    Host = wrq:get_req_header("host", ReqData),
    "http://" ++ Host ++ "/".
to_json(ReqData, State) ->
    {ok, LatestLinks} = petite_url_srv:get_latest(20),
    LinkList = lists:map(
                 fun({Code, Link}) ->
                         ShortLink = base_url(ReqData) ++ Code,
                         {struct, [{<<"short_link">>, list_to_binary(ShortLink)}, %% (3)
                                   {<<"long_link">>, list_to_binary(Link)}]}
                 end,
                 LatestLinks),
    Result = mochijson2:encode({struct, [{latest, LinkList}]}), %% (4)
    {[Result, "\n"], ReqData, State}.
