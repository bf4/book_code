%.beam: %.erl
	erlc  -W $< 

%.o: %.c
	gcc -c -m32 -g -Wall -fPIC\
            -I/usr/local/lib/erlang/lib/erl_interface-3.7.6/include\
            -I/usr/local/lib/erlang/erts-5.9/include $<

all: nif_test1.so nif_test1.beam nif_test2.so nif_test2.beam nif_test3.so\
     nif_test3.beam darray.so darray_test.beam test1_nif.so

nif_test1.so: nif_test1.o
	cc nif_test1.o -arch i386\
                       -bundle -flat_namespace -undefined suppress\
                       -L/usr/local/lib/erlang/lib/erl_interface-3.7.6/lib\
                       -lerl_interface -lei -o nif_test1.so

test1_nif.so: test1_nif.o
	cc test1_nif.o -arch i386\
                       -bundle -flat_namespace -undefined suppress\
                       -L/usr/local/lib/erlang/lib/erl_interface-3.7.6/lib\
                       -lerl_interface -lei -o test1_nif.so

nif_test2.so: nif_test2.o
	cc nif_test2.o -arch i386\
                       -bundle -flat_namespace -undefined suppress\
                       -L/usr/local/lib/erlang/lib/erl_interface-3.7.6/lib\
                       -lerl_interface -lei -o nif_test2.so

nif_test3.so: nif_test3.o
	cc nif_test3.o -arch i386\
                       -bundle -flat_namespace -undefined suppress\
                       -L/usr/local/lib/erlang/lib/erl_interface-3.7.6/lib\
                       -lerl_interface -lei -o nif_test3.so

darray.so: darray.o
	cc darray.o -arch i386\
                       -bundle -flat_namespace -undefined suppress\
                       -L/usr/local/lib/erlang/lib/erl_interface-3.7.6/lib\
                       -lerl_interface -lei -o darray.so

clean:
	rm -rf *.o *.beam *.so
