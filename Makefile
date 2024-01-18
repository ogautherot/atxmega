#
# ATXmega128a3 template
# Type: avr:106
#

export PATH := /usr/local/avr8-gnu-toolchain-linux_x86_64/bin:${PATH}

CC=avr-gcc
CXX=avr-g++
SIZE=avr-size

ARCH=atxmega128a3

TARGET=build/atxmega

# Boot loader-related objects
OBJS=obj/bl_main.o 

# Application modules
OBJS+=obj/main.o

CFLAGS=-Og -g -mmcu=${ARCH}
LDFLAGS=-Wl,"-Tld/atxmega128a3.ld" -Xlinker -Map=${TARGET}.map


.PHONY: all
all: ${TARGET}
	${SIZE} ${TARGET}

${TARGET}: ${OBJS}
	mkdir -p build
	${CXX} ${CFLAGS} -o ${TARGET} ${OBJS} ${LDFLAGS}


obj/%.o: src/%.c
	mkdir -p obj
	${CC} -c ${CFLAGS} -o $@ $<

obj/%.o: src/%.c++
	mkdir -p obj
	${CXX}++ -c ${CFLAGS} -o $@ $<

.PHONY: clean
clean:
	rm -f ${OBJS} ${TARGET} build/* *.map 

