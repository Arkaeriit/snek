all : clean test.bin

cusedLua.o : cursedLua.c cursedLua.h
	gcc -c cursedLua.c -Wall -o cursedLua.o

luaSleep.o : luaSleep.c luaSleep.h
	gcc -c luaSleep.c -Wall -o luaSleep.o

main.o : exemple.c cursedLua.h
	gcc -c exemple.c -o main.o

test.bin : main.o cursedLua.o luaSleep.o
	gcc main.o cursedLua.o luaSleep.o -lncursesw -llua -lm -ldl -o test.bin

clean : 
	rm -f *.bin
	rm -f *.o

