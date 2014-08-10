all: pfctest

############################################################

strextra.o: strextra.c strextra.h
	gcc -std=c99 -fPIC -c strextra.c

############################################################

pfc.o: pfc.c pfc.h strextra.h
	gcc -std=c99 -fPIC -c pfc.c -I/usr/include/libxml2

pfc.so: pfc.o strextra.o
	gcc -std=c99 -shared -o pfc.so pfc.o strextra.o

############################################################

pfctest.o: pfctest.c pfc.h
	gcc -std=c99 -c pfctest.c

pfctest: pfc.so pfctest.o
	gcc -std=c99 -o pfctest pfc.so pfctest.o -lxml2

############################################################

clean:
	-rm *.o
	-rm *.so
	-rm pfctest

.PHONY: all
.PHONY: clean
