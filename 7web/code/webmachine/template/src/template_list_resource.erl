%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(template_list_resource).
-export([init/1, to_html/2]).

-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.
to_html(ReqData, State) ->
    Template = "<html><body>" ++
        "<ul>" ++
        "{{#urls}}" ++
        "<li>{{ url }}</li>" ++
        "{{/urls}}" ++
        "</ul>" ++
        "</body></html>",
    Urls = [{url, "https://pragprog.com/"}, %% (1)
            {url, "https://github.com/basho/webmachine"},
            {url, "https://github.com/mojombo/mustache.erl"}],
    Dicts = [dict:from_list([U]) || U <- Urls], %% (2)
    Context = dict:from_list([{urls, Dicts}]), %% (3)
    Response = mustache:render(Template, Context),
    {Response, ReqData, State}.
