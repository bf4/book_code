%% ---
%%  Excerpted from "Cucumber Recipes",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/dhwcr for more book information.
%%---
-module(handset).

-export([given/3, main/0]).

main() ->
  cucumberl:run("./features/handset.feature").

% START:given
given([a, call, is, in, progress], World, _) ->
    {ok, World};
given([no, calls, are, in, progress], World, _) ->
    {ok, World}.
% END:given
