
OBJS=obj/bl_main.o
TARGET=atxmega
ARCH=atxmega128a3
CFLAGS=-Og -g -mmcu=${ARCH}
LDFLAGS=-Wl,"-T ld/atxmega128a3.ld"

CC=avr-g++
SIZE=avr-size

.PHONY: all
all: ${TARGET}
	${SIZE} ${TARGET}

${TARGET}: ${OBJS}
	${CC} ${CFLAGS} -o ${TARGET} ${OBJS} ${LDFLAGS}


obj/%.o: src/%.c
	${CC} -S ${CFLAGS} $<
	${CC} -c ${CFLAGS} -o $@ $<

obj/%.o: src/%.c++
	${CC}++ -c ${CFLAGS} -o $@ $<

.PHONY: clean
clean:
	rm ${OBJS} ${TARGET}

