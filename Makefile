all: xtctest xtc

############################################################

strextra.o: strextra.c strextra.h
	gcc -std=c99 -fPIC -c strextra.c

############################################################

xtc.o: xtc.c xtc.h strextra.h
	gcc -std=c99 -fPIC -c xtc.c -I/usr/include/libxml2

libxtc.so: xtc.o strextra.o
	gcc -std=c99 -shared -o libxtc.so xtc.o strextra.o -lxml2

############################################################

xtctest.o: xtctest.c xtc.h
	gcc -std=c99 -c xtctest.c

xtctest: libxtc.so xtctest.o
	gcc -std=c99 -o xtctest xtctest.o -L. -lxtc

############################################################

xtc_cmd.o: xtc_cmd.c
	gcc -std=c99 -c xtc_cmd.c

xtc: xtc_cmd.o
	gcc -std=c99 -o xtc xtc_cmd.o -ldl

############################################################

clean:
	-rm *.o
	-rm *.so
	-rm xtctest
	-rm xtc

.PHONY: all
.PHONY: clean
