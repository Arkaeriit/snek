# Flags
FLAGS := -Wall -Werror
NC := -lncursesw
LUA := -llua -lm -ldl  

# Files lists
C_SRC := main.c cursedLua.c luaSleep.c gestionFS.c
C_OBJS := $(C_SRC:%.c=%.o)
LUA_SRC := main.lua snek.lua maps.lua position.lua info.lua mapsGenerator.luac
LUA_OBJS := $(LUA_SRC:%.lua=%.luac)

# Install targets
TARGET_DIR := /usr/local/share/snek
TARGET_DIR_MAP := $(TARGET_DIR)/maps
TARGET_DIR_BIN := /usr/local/bin
TARGET_BIN := $(TARGET_DIR_BIN)/snek

# Commands
CC := gcc
CP := cp -f
RM := rm -rf

all : snek.bin

%.luac : %.lua
	luac -o $@ $<

%.o : %.c
	$(CC) -c $< $(FLAGS) -o $@

snek.bin : $(C_OBJS) $(LUA_OBJS)
	$(CC) $(C_OBJS) $(FLAGS) $(NC) $(LUA) -o snek.bin

install :
	mkdir -p $(TARGET_DIR) $(TARGET_DIR_BIN) $(TARGET_DIR_MAP)
	$(CP) $(LUA_OBJS) $(TARGET_DIR)
	$(CP) snek.bin $(TARGET_BIN)
	$(CP) maps/* $(TARGET_DIR_MAP)

unistall :
	$(RM) $(TARGET_DIR) $(TARGET_DIR_MAP)
	$(RM) $(TARGET_BIN)

clean : 
	$(RM) *.bin
	$(RM) *.o
	$(RM) *.luac

test : snek.bin
	./snek.bin

