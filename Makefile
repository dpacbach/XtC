all: xtctest

############################################################

strextra.o: strextra.c strextra.h
	gcc -std=c99 -fPIC -c strextra.c

############################################################

xtc.o: xtc.c xtc.h strextra.h
	gcc -std=c99 -fPIC -c xtc.c -I/usr/include/libxml2

xtc.so: xtc.o strextra.o
	gcc -std=c99 -shared -o xtc.so xtc.o strextra.o

############################################################

xtctest.o: xtctest.c xtc.h
	gcc -std=c99 -c xtctest.c

xtctest: xtc.so xtctest.o
	gcc -std=c99 -o xtctest xtc.so xtctest.o -lxml2

############################################################

clean:
	-rm *.o
	-rm *.so
	-rm xtctest

.PHONY: all
.PHONY: clean
