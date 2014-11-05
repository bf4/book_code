%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(petite_static_resource).
-export([init/1,
         resource_exists/2,
         content_types_provided/2,
         provide_content/2]).

-include_lib("kernel/include/file.hrl").
-include_lib("webmachine/include/webmachine.hrl").

-record(ctx, {root, path}).

init([RootPath]) ->
    Path = code:priv_dir(petite) ++ "/" ++ RootPath,
    {ok, #ctx{root=Path}}.

resource_exists(ReqData, State=#ctx{root=Root}) ->
    DispPath = wrq:disp_path(ReqData),
    FilePath = Root ++ "/" ++ DispPath,
    case file:read_file_info(FilePath) of
        {ok, FileInfo} ->
            case {FileInfo#file_info.type, FileInfo#file_info.access} of
                {regular, Access} when Access =:= read; Access =:= read_write ->
                    {true, ReqData, State#ctx{path=FilePath}};
                _ ->
                    {false, ReqData, State}
            end;
        {error, _} ->
            {false, ReqData, State}
    end.

content_types_provided(ReqData, State) ->
    Mime = webmachine_util:guess_mime(wrq:path(ReqData)),
    {[{Mime, provide_content}], ReqData, State}.

provide_content(ReqData, State=#ctx{path=Path}) ->
    {ok, Body} = file:read_file(Path),
    {Body, ReqData, State}.
