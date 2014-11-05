%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(type_examples).
-compile(export_all).

-type trafficLightColor() :: red | amber | green.
-type sex()               :: male | female.
-type apple()             :: {string(), string(), integer()}.

-type footSize()          :: integer().

-spec next_color(Old:: trafficLightColor() ) -> New::trafficLightColor().

next_color(red)   -> amber;
next_color(amber) -> green; 
next_color(green) -> red. 

fac(0) -> 1;
fac(N) -> N * fac(N-1).
 
test() ->
    fac(-8).

-spec funny(1) -> 1.

funny(_) -> 1.

test1() ->
    funny(12).


     




