MODS := $(wildcard *.erl)

%.beam: %.erl
	erlc -W $<

all: beam
	erl -pa deps/cowboy/ebin -pa deps/ranch/ebin -s irc start -s websockets start_link 2233 `pwd`	

beam: ${MODS:%.erl=%.beam}

clean:
	rm -rf *.beam *.so *.o *~ erl_crash.dump



