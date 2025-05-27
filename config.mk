CC = gcc
AR = ar rc
RANLIB = ranlib
RM = rm

CSTD = -std=c99
WARNINGS = \
	-Wall -Wextra -Wshadow -Wundef -Wwrite-strings -Wconversion \
	-Wstrict-overflow=2 -Wdeclaration-after-statement \
	-Wmissing-prototypes -Wnested-externs -Wc++-compat \
	-Wold-style-definition -Wlogical-op

CFLAGS = -O2 $(CSTD) $(WARNINGS) -fno-stack-protector -fno-common -march=native
LDFLAGS = 
LIBS = -lm

ifeq ($(PLATFORM),LINUX)
	CFLAGS += -DLUA_USE_LINUX
	LDFLAGS += -Wl,-E 
	LIBS += -ldl
	RM += -f
endif

ifeq ($(PLATFORM),WINDOWS)
    CFLAGS += -LUA_USE_WINDOWS
	LDFLAGS += -Wl,-E
	RM += -Force
endif

ifeq ($(PLATFORM),MACOS)
	CFLAGS += -LUA_USE_MACOSX
	LDFLAGS += -Wl
endif