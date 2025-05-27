include config.mk

ifdef OS
	ifeq ($(OS),Windows_NT)
		PLATFORM := WINDOWS
	else
		UNAME_S := $(shell uanme -s)
		ifdef ($(UNAME_S),Linux)
			PLATFORM := LINUX
		endif
		ifeq ($(UNAME_S),Darwin)
			PLATFORM := MACOS
		endif
	endif
endif

TARGET = lua
LIB = liblua.a

CORE_SRC = lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c \
           llex.c lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c \
           ltable.c ltm.c lundump.c lvm.c lzio.c
AUX_SRC = lauxlib.c
LIB_SRC = lbaselib.c ldblib.c liolib.c lmathlib.c loslib.c ltablib.c \
          lstrlib.c lutf8lib.c loadlib.c lcorolib.c linit.c
MAIN_SRC = lua.c

CORE_OBJ = $(CORE_SRC:.c=.o)
AUX_OBJ = $(AUX_SRC:.c=.o)
LIB_OBJ = $(LIB_SRC:.c=.o)
MAIN_OBJ = $(MAIN_SRC:.c=.o)

ALL_OBJ = $(CORE_OBJ) $(AUX_OBJ) $(LIB_OBJ)
ALL = $(LIB) $(TARGET)

all: $(ALL)

$(LIB): $(CORE_OBJ) $(AUX_OBJ) $(LIB_OBJ)
	$(AR) $@ $^
	$(RANLIB) $@

$(TARGET): $(MAIN_OBJ) $(LIB)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
	
clean:
	$(RM) $(ALL) $(ALL_OBJ) $(MAIN_OBJ)

depend:
	@$(CC) $(CFLAGS) -MM *.c > .depend

-include .depend