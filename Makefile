FLAGS = -Wall -Werror
CL = -lcursedLua
GFS = -lgestionFS
LUA = -llua -lm -ldl  

all : snek.bin

maps.luac : maps.lua
	luac -o maps.luac maps.lua

snek.luac : snek.lua
	luac -o snek.luac snek.lua

main.luac : main.lua
	luac -o main.luac main.lua

position.luac : position.lua
	luac -o position.luac position.lua

mapsGenerator.luac : mapsGenerator.lua
	luac -o mapsGenerator.luac mapsGenerator.lua

info.luac : info.lua
	luac -o info.luac info.lua

luaSleep.o : luaSleep.c luaSleep.h
	gcc -c luaSleep.c $(FLAGS) -o luaSleep.o

main.o : main.c
	gcc -c main.c $(FLAGS) -o main.o

snek.bin : main.o luaSleep.o maps.luac position.luac main.luac snek.luac mapsGenerator.luac info.luac
	gcc main.o luaSleep.o $(FLAGS) $(CL) $(LUA) $(GFS) -o snek.bin

install :
	mkdir -p /usr/local/share/snek
	mkdir -p /usr/local/share/snek/maps
	cp -f snek.luac /usr/local/share/snek/
	cp -f maps.luac /usr/local/share/snek/
	cp -f position.luac /usr/local/share/snek/
	cp -f mapsGenerator.luac /usr/local/share/snek/
	cp -f info.luac /usr/local/share/snek/
	cp -f main.luac /usr/local/share/snek/
	cp -f snek.bin /usr/local/bin/snek
	cp -f maps/* /usr/local/share/snek/maps/

unistall :
	rm -rf /usr/lcal/share/snek
	rm -f /usr/local/bin/snek

clean : 
	rm -f *.bin
	rm -f *.o
	rm -f *.luac

test : snek.bin
	./snek.bin

