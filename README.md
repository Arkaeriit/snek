# Snek
A ncurses snake game.

This game is a snake game written mosty in Lua with the same library to use ncurses in Lua than evenmorelua.

![Alt text](https://i.imgur.com/Dj0UZdp.png "Reading a file")

## Installation
To install this just use
```bash
make && sudo make install
```

## User manual

### Start the game
To start the game just type `snek` and the game will start in a map adapted to the size of your terminal.

### Play the game
The aim of the game is to have the biggest snake possible. The head of the snake is represented by a `@` and it's body by `+`. To make the smake grow it must eat fruit represented by red `o`. Be careful, the snake can't hit a wall or bit it's own tail, otherwize you loose.

To control the snake, use the arrow keys.

