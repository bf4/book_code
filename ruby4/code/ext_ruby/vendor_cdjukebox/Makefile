lib/libcdjukebox.a: cdjukebox.o
	$(AR) cru lib/libcdjukebox.a cdjukebox.o
	ranlib lib/libcdjukebox.a


cdjukebox.o:	include/cdjukebox.h src/cdjukebox.c
	gcc -c -o cdjukebox.o -I include src/cdjukebox.c

clean:
	rm -f *.o lib/*.a *~
