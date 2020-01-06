/*----------------------------------------------------\
|Ces fonctions ont pour but d'être appelés en lua pour|
|se servir de sleep en lua.                           |
\----------------------------------------------------*/

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <unistd.h>

int lS_usleep(lua_State* L);
int lS_msleep(lua_State* L);
int lS_sleep(lua_State* L);

void lS_include(lua_State* L);

