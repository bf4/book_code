LIB=/usr/local/rubybook/lib
INC=/usr/local/rubybook/include/ruby-1.9.0/ruby
CFLAGS=-I$(INC) -g
LDFLAGS=-L$(LIB) -lruby -ldl -lobjc

embed:	embed.o
	$(CC) -o embed embed.o $(LDFLAGS)
