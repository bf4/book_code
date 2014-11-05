LIB=/usr/local/rubybook/lib
INC=/usr/local/rubybook/include/ruby-1.9.0/ruby
CFLAGS=-I$(INC) -g
LDFLAGS=-L$(LIB) -lruby -ldl -lobjc

embed2:	embed2.o
	$(CC) -o embed2 embed2.o $(LDFLAGS)
