%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the cache application.

-module(cache_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for cache.
start(_Type, _StartArgs) ->
    cache_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for cache.
stop(_State) ->
    ok.
