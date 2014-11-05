%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(types3).

-compile(export_all).

-type day() :: sunday | monday | tuesday | wednesday | thursday 
	     | friday | saturday.

-spec day_of_week(day()) -> integer().

day_of_week(sunday)    -> 1;
day_of_week(modnay)    -> 2; %% TYPO !!
day_of_week(tuesday)   -> 3;
day_of_week(wednesday) -> 4;
day_of_week(thursday)  -> 5;
day_of_week(friday)    -> 6;
day_of_week(saturday)  -> 7.

test1() -> day_of_week(modnay).

test2() -> day_of_week(chockolate).

test3() -> day_of_week(friday).
    
%% dialyzer types3.erl
%%   Checking whether the PLT /Users/joe/.dialyzer_plt is up-to-date... yes
%%   Proceeding with analysis...
%% types3.erl:18: Function test1/0 has no local return
%% types3.erl:18: The call types3:day_of_week('modnay') 
%%   breaks the contract (day()) -> integer()
%% types3.erl:20: Function test2/0 has no local return
%% types3.erl:20: The call types3:day_of_week('chockolate') will never return 
%%   since the success typing is ('friday' | 'modnay' | 'saturday' | 'sunday' | 
%%   'thursday' | 'tuesday' | 'wednesday') -> 1 | 2 | 3 | 4 | 5 | 6 | 7 
%%   and the contract is (day()) -> integer()

%% What's happening here? test1/0 has no local value
%% In fact there is no error types3:test1() returns 2
%% The contract is broken - so it's nice to get a warning
%% but the error message confuses me

    


    
