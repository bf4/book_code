%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(types1).

-compile(export_all).

myand1(true, true) -> true;   
myand1(false, _)   -> false; 
myand1(_, false)   -> false.

-spec myand2(boolean(), boolean()) -> boolean().
myand2(true, true) -> true;   
myand2(false, _)   -> false; 
myand2(_, false)   -> false.
 
myand3(true,  true)  -> true;   
myand3(false, true)  -> false; 
myand3(true,  false) -> false;
myand3(false, false) -> false.

bug1(X, Y) ->
    case myand1(X, Y) of
	true ->
	    X + Y
    end.

bug2(X, Y) ->
    case myand2(X, Y) of
	true ->
	    X + Y
    end.

bug3(X, Y) ->
    case myand3(X, Y) of
	true ->
	    X + Y
    end.

-type day() :: sunday | monday | tuesday | wednesday | thursday 
	     | friday | saturday.

-spec day_of_week(day()) -> integer().

day_of_week(sunday) -> 1;
day_of_week(modnay) -> 2;
day_of_week(saturday) -> a.


    
