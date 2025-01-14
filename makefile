# Makefile for TinyScheme
# Time-stamp: <2002-06-24 14:13:27 gildea>

#FIXME: add other platforms install's

# Windows/2000
#CC = cl -nologo
#DEBUG= -W3 -Z7 -MD
#DL_FLAGS=
#SYS_LIBS=
#Osuf=obj
#SOsuf=dll
#LIBsuf=.lib
#EXE_EXT=.exe
#LD = link -nologo
#LDFLAGS = -debug -map -dll -incremental:no
#LIBPREFIX =
#OUT = -out:$@
#RM= -del
#AR= echo

# Unix, generally
CC = gcc -fpic -pedantic
#DEBUG=-g -Wall -Wno-char-subscripts -O
DEBUG=-Os
Osuf=o
SOsuf=so
LIBsuf=a
EXE_EXT=
LIBPREFIX=lib
OUT = -o $@
RM= -rm -f
AR= ar crs
CP= cp
MKD= mkdir -p
INSTALL_BIN_DIR = /usr/bin
INSTALL_LIB_DIR = /usr/lib/tinyscheme
INSTALL_INIT_FILE = "/usr/lib/tinyscheme/init.scm"

# Linux
LD = gcc
LDFLAGS = -fpic -shared
#DEBUG=-g -Wno-char-subscripts -O
DEBUG=-Os -Wno-char-subscripts
SYS_LIBS= -ldl -lm -lreadline
PLATFORM_FEATURES= -DSUN_DL=1 -DUSE_READLINE=1

# Cygwin
#PLATFORM_FEATURES = -DUSE_STRLWR=0

# MinGW/MSYS
#SOsuf=dll
#PLATFORM_FEATURES = -DUSE_STRLWR=0

# Mac OS X
#LD = gcc
#LDFLAGS = --dynamiclib
#DEBUG=-g -Wno-char-subscripts -O
#SYS_LIBS= -ldl
#PLATFORM_FEATURES= -DUSE_STRLWR=1 -D__APPLE__=1 -DOSX=1


# Solaris
#SYS_LIBS= -ldl -lc
#Osuf=o
#SOsuf=so
#EXE_EXT=
#LD = ld
#LDFLAGS = -G -Bsymbolic -z text
#LIBPREFIX = lib
#OUT = -o $@

FEATURES = $(PLATFORM_FEATURES) -DUSE_DL=1 -DUSE_MATH=1 -DUSE_ASCII_NAMES=1

OBJS = scheme.$(Osuf) dynload.$(Osuf)

LIBTARGET = $(LIBPREFIX)tinyscheme.$(SOsuf)
STATICLIBTARGET = $(LIBPREFIX)tinyscheme.$(LIBsuf)

all: $(LIBTARGET) $(STATICLIBTARGET) tinyscheme$(EXE_EXT)

%.$(Osuf): %.c
	$(CC) -I. -c $(DEBUG) $(FEATURES) $(DL_FLAGS) $<

$(LIBTARGET): $(OBJS)
	$(LD) $(LDFLAGS) $(OUT) $(OBJS) $(SYS_LIBS)

tinyscheme$(EXE_EXT): $(OBJS)
	$(CC) -o $@ $(DEBUG) $(OBJS) $(SYS_LIBS)

indent:
	indent *.c *.h -linux -brf -l100 -ut

$(STATICLIBTARGET): $(OBJS)
	$(AR) $@ $(OBJS)

$(OBJS): scheme.h scheme-private.h opdefines.h
dynload.$(Osuf): dynload.h

clean:
	$(RM) $(OBJS) $(LIBTARGET) $(STATICLIBTARGET) tinyscheme$(EXE_EXT)
	$(RM) tinyscheme.ilk tinyscheme.map tinyscheme.pdb tinyscheme.exp
	$(RM) scheme.ilk scheme.map scheme.pdb scheme.lib scheme.exp
	$(RM) *~

TAGS_SRCS = scheme.h scheme.c dynload.h dynload.c

tags: TAGS
TAGS: $(TAGS_SRCS)
	etags $(TAGS_SRCS)

install:
	$(CP) tinyscheme$(EXE_EXT) $(INSTALL_BIN_DIR)
	$(MKD) $(INSTALL_LIB_DIR)
	$(CP) init.scm $(INSTALL_LIB_DIR)
