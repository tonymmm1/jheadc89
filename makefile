#--------------------------------
# jhead makefile for Unix
#--------------------------------
OBJ=src
SRC=src
INCLUDE_DIR=include
CFLAGS:= -std=c89 -Wall -Wextra -fpic -I$(INCLUDE_DIR)
LDFLAGS:=$(shell dpkg-buildflags --get LDFLAGS)

all: jhead

objs = $(OBJ)/jhead.o $(OBJ)/jpgfile.o $(OBJ)/jpgqguess.o $(OBJ)/paths.o \
	$(OBJ)/exif.o $(OBJ)/iptc.o $(OBJ)/gpsinfo.o $(OBJ)/makernote.o 

$(OBJ)/%.o:$(SRC)/%.c
	${CC} $(CFLAGS) $(CPPFLAGS) -c $< -o $@

jhead: $(objs) $(INCLUDE_DIR)/jhead.h
	${CC} $(LDFLAGS) -o jhead $(objs) -lm

clean:
	rm -f $(objs) jhead

install:
	cp jhead ${DESTDIR}/usr/bin/
