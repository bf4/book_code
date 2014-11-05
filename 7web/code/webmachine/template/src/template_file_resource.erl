%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(template_file_resource).
-export([init/1, to_html/2]).
-include_lib("webmachine/include/webmachine.hrl").

init([]) -> {ok, undefined}.
to_html(ReqData, State) ->
    {ok, TemplateBin} = file:read_file(
                          code:priv_dir(template) ++ "/simple.mustache"),
    TemplateStr = binary_to_list(TemplateBin),
    Context = dict:from_list([{message, "Hello from a file"}]),
    Response = mustache:render(TemplateStr, Context),
    {Response, ReqData, State}.
