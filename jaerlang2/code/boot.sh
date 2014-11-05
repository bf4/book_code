#!/usr/bin/env escript
#---
# Excerpted from "Programming Erlang, Second Edition",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/jaerlang2 for more book information.
#---
%% -*- erlang -*-
%%! -sname ehe_node

main(_) ->
    Files  = filelib:wildcard("*.beam"),
    Files1 = filelib:wildcard(
	       "/home/joe/nobackup/erlang_imports/deps/cowboy/ebin/*.beam"),
    Files2 =  filelib:wildcard("*.html"),
    Files3 =  filelib:wildcard("*.js"),
    Files4 =  filelib:wildcard("*.css"),
    All = Files ++ Files1 ++ Files2 ++ Files3 ++ Files4,
    Stuff = [input(I) || I <- All],
    io:format("Packing:~p~n",[All]),
    case zip:create("mem", Stuff, [memory]) of
	{ok, {"mem", ZipBin}} ->
	    io:format("ok1~n"),
            %% Archive was successfully created. Prefix that binary with our
            %% header and write to our escript file
            Shebang = "#!/usr/bin/env escript\n%%! -noshell -noinput\n",
            Script = iolist_to_binary([Shebang, ZipBin]),
            case file:write_file("web", Script) of
                ok ->
		    os:cmd("chmod u+x web"),
                    ok;
                {error, WriteError} ->
                    io:format("Failed to write script: ~p\n",
			      [WriteError])
	    end;
	E ->
	    io:format("uugh:~p~n",[E])
    end,
    init:stop().



input(F) ->
    {ok, Bin} = file:read_file(F),
    {filename:basename(F), Bin}.

