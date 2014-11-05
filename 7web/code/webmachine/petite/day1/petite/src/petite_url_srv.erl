%% ---
%%  Excerpted from "Seven Web Frameworks in Seven Weeks",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/7web for more book information.
%%---
-module(petite_url_srv).

%% public API
-export([start_link/0,
         get_url/1,
         put_url/1]).

-behaviour(gen_server).
-export([init/1,
         terminate/2,
         code_change/3,
         handle_call/3,
         handle_cast/2,
         handle_info/2]).

-define(SERVER, ?MODULE).
-define(TAB, petite_urls).

-record(st, {next}).

%% public API implementation

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

get_url(Id) -> %% (1)
    gen_server:call(?SERVER, {get_url, Id}).

put_url(Url) ->
    gen_server:call(?SERVER, {put_url, Url}).

%% gen_server implementation

init(_) -> %% (2)
    ets:new(?TAB, [set, named_table, protected]),
    {ok, #st{next=0}}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

handle_call({get_url, Id}, _From, State) -> %% (3)
    Reply = case ets:lookup(?TAB, Id) of
                [] ->
                    {error, not_found};
                [{Id, Url}] ->
                    {ok, Url}
            end,
    {reply, Reply, State};

handle_call({put_url, Url}, _From, State = #st{next=N}) -> %% (4)
    Id = b36_encode(N),
    ets:insert(?TAB, {Id, Url}),
    {reply, {ok, Id}, State#st{next=N+1}};

handle_call(_Request, _From, State) ->
    {stop, unknown_call, State}.

handle_cast(_Request, State) ->
    {stop, unknown_cast, State}.

handle_info(_Info, State) ->
    {stop, unknown_info, State}.

%% internal functions

b36_encode(N) -> %% (5)
   integer_to_list(N, 36).
