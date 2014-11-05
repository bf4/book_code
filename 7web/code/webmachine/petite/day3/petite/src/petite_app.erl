%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
%% @doc Callbacks for the petite application.

-module(petite_app).

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for petite.
start(_Type, _StartArgs) ->
    petite_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for petite.
stop(_State) ->
    ok.
