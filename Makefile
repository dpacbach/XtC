all: pfctest
.PHONY: all

pfctest.o: pfctest.c pfc.h
	gcc -std=c99 -c pfctest.c

pfc.o: pfc.c pfc.h
	gcc -std=c99 -c pfc.c -I/usr/include/libxml2

pfctest: pfc.o pfctest.o
	gcc -o pfctest pfc.o pfctest.o -lxml2

clean:
	-rm *.o
	-rm pfctest
.PHONY: clean
