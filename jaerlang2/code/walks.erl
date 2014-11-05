%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(walks).
-export([plan_route/2]).

-spec plan_route(point(), point()) -> route().

-type direction() :: north | south | east | west.
-type point()     :: {integer(), integer()}.
-type route()     :: [{go,direction(),integer()}].
%% there is no code here
%% this is deliberate
plan_route({X1,Y1}, {X2, Y2}) ->
    [].

-type angle()       :: {Degrees::0..360, Minutes::0..60, Seconds::0..60}.
-type position()    :: {latitude | longitude, angle()}.
-spec plan_route1(From::position(), To::position()) -> [].

plan_route1(_,_) ->
    a.



    
