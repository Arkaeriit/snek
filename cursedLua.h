/*----------------------------------------------------\
|Ces fonctions ont pour but d'être appelés en lua pour|
|se servir de ncurses en lua.                         |
\----------------------------------------------------*/

#include <ncurses.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <locale.h>

//Foncions qui servent à un crontrole général de l'écrant

int cl_init(lua_State *L); //permet d'initialiser ncurses
int cl_echo(lua_State *L);
int cl_noecho(lua_State *L);
int cl_close(lua_State *L); //permet de fermer ncurses
int cl_cursset(lua_State *L); //permet de chisir l'état du curseur
int cl_refresh(lua_State *L); //permet de réactualiser l'écrant
int cl_getxy(lua_State *L); //Permet de savoir les dimentions de l'écrant
int cl_getch(lua_State *L); //Permet de récupérer les inputs de l'utilisateur
int cl_hascolor(lua_State *L);
int cl_startcolor(lua_State *L);
int cl_defaultcolors(lua_State *L); //permet d'avoir use_deffault_colors
int cl_init_pair(lua_State *L); //Permet d'initialiser une paie de couleur.

//Fonctions servant à écrire sur l'écrant

int cl_mvprintw(lua_State *L); //permet d'écrire sur l'écrant
int cl_color(lua_State *L); //S'occupe du choix des couleurs, ne marche pas dirrectement comme dans ncurses mais est plus direct, on l'utilise avec deux arguments en entrée pour le choix des couleurs et les couleurs sont choisies.
int cl_set_color(lua_State *L); //Permet de choisir sur l'écran une paire de couleur.


//fonction à appeler en C pour charger la librairie

void cl_include(lua_State *L); //Permet d'inclure dans le lua_State les autres fonctions
