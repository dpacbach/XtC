all: pfctest

pfctest.o: pfctest.c pfc.h
	gcc -std=c99 -c pfctest.c

pfc.o: pfc.c pfc.h
	gcc -std=c99 -c pfc.c

pfctest: pfc.o pfctest.o
	gcc -o pfctest pfc.o pfctest.o

clean:
	rm *.o
	rm pfctest
