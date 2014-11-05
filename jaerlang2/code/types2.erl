%% ---
%%  Excerpted from "Programming Erlang, Second Edition",
%%  published by The Pragmatic Bookshelf.
%%  Copyrights apply to this code. It may not be used to create training material, 
%%  courses, books, articles, and the like. Contact us if you are in doubt.
%%  We make no guarantees that this code is fit for any purpose. 
%%  Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
%%---
-module(types2).

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

%% dialyzer types2.erl
%%   Checking whether the PLT /Users/joe/.dialyzer_plt is up-to-date... yes
%%   Proceeding with analysis... done in 0m0.41s
%% done (passed successfully)
    
%% I'd rather hoped to get an error here.

%% dialyzer -Wspecdiffs types2.erl
%%   Checking whether the PLT /Users/joe/.dialyzer_plt is up-to-date... yes
%%   Proceeding with analysis...
%% types2.erl:8: Type specification types2:day_of_week(day()) -> integer() is 
%%    not equal to the success typing: types2:day_of_week('friday' | 'modnay' | 
%%    'saturday' | 'sunday' | 'thursday' | 'tuesday' | 'wednesday') -> 1 | 2 | 3 
%%    | 4 | 5 | 6 | 7
%%  done in 0m0.41s


%% The dialyzer manual says

%% The following options are also available but their use is 
%%%  not recommended: (they are mostly for Dialyzer
%%        developers and internal debugging)

%%          -Woverspecs***:
%%            Warn about overspecified functions (the -spec is strictly 
%%            less allowing than the success typing).

%%          -Wspecdiffs***:
%%            Warn when the -spec is different than the success typing.    


%% Why is -Wspecdiffs not recommended


    
