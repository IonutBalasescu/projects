
build: libso_stdio.so

libso_stdio.so: so_stdio.o
	gcc -shared so_stdio.o -o libso_stdio.so

so_stdio.o:
	gcc -fPIC -c so_stdio.c

clean:
	rm -f libso_stdio.so so_stdio.o
