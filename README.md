# Snek
A ncurses snake game.

This game is a snake game written mostly in Lua with the same library to use ncurses in Lua than evenmorelua.

![Alt text](https://i.imgur.com/Dj0UZdp.png "A default map")

## Installation
To install evenmorelua you need the library cursedLua, available here: https://github.com/Arkaeriit/cursedLua.
You also need the library ASCgestionFS, available here: https://github.com/Arkaeriit/ASCgestionFS.

When the libraries are installed, this just use: 
```bash
make && sudo make install
```

## User manual

### Start the game
To start the game just type `snek` and the game will start in a map adapted to the size of your terminal.

You can also play a custom map. To do so type `snek ` followed by the name of the map. For example `snek Factory` will start the map factory. You can list all available maps by typing `snek map`

### Play the game
The goal of the game is to have the biggest snake possible. The head of the snake is represented by a `@` and it's body by `+`. To make the smake grow it must eat fruit represented by red `o`. Be careful, the snake can't hit a wall or bite its tail, otherwise, you lose.

To control the snake, use the arrow keys. You can pause the game by pressing `p` and resume it by pressing enter.

### Creating custom maps
If you want to create a custom map, you can. Maps are contained in a single ASCII file. The first line contains a description of the map. The second line contains the number of fruits that will be spawned on the map. The third and fourth lines are the starting coordinates of the snake (the third line is the starting line and the fourth line is the starting column). The fifth line contains the size at which the snake is considered winning (if there is no number, it will default to the number of ground tiles).

After that is a representation in ASCII characters of the map. Each line of the representation corresponds to a line of the map. The tiles are represented as follows:

| Char in the file | Equivalent tile | Description                         |
|:----------------:|:---------------:|:-----------------------------------:|
| 0                | Void            | A tile where no fruit can spawn.    |
| 1                | Ground          | A tile where fruits can spawn.      |
| 2                | Wall            | A tile where the snake can't go.    |
| 5                | Fruit           | A bonus fruit you choose the place. |

Newline and carriage return are ignored and every other character is interpreted as a void tile.

You can play your map by typing in a terminal `snek ` followed by the file name of the map or you can install it by putting it in /usr/share/snek/maps or /usr/local/share/snek/maps.

![Alt text](https://i.imgur.com/VxuUnyX.png "Example with a picture")

