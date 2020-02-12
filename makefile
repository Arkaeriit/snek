all : clean test.bin

maps.luac : maps.lua
	luac -o maps.luac maps.lua

snek.luac : snek.lua
	luac -o snek.luac snek.lua

main.luac : main.lua
	luac -o main.luac main.lua

position.luac : position.lua
	luac -o position.luac position.lua

cusedLua.o : cursedLua.c cursedLua.h
	gcc -c cursedLua.c -Wall -o cursedLua.o

luaSleep.o : luaSleep.c luaSleep.h
	gcc -c luaSleep.c -Wall -o luaSleep.o

main.o : main.c
	gcc -c main.c -o main.o

test.bin : main.o cursedLua.o luaSleep.o maps.luac position.luac main.luac snek.luac
	gcc main.o cursedLua.o luaSleep.o -lncursesw -llua -lm -ldl -o test.bin

clean : 
	rm -f *.bin
	rm -f *.o

