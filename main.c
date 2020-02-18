/*--------------------------------------------\
This file is used to start the Lua program and|
load lirairies and luac files.                |
\--------------------------------------------*/

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include "cursedLua.h"
#include "luaSleep.h"

//Choosing local file or global ones
#define DEVEL 0

int main(){
    lua_State* L;
    L = luaL_newstate();

    //Loading librairies
    luaL_openlibs(L);
    cl_include(L);
    lS_include(L);

    //Loading lua files
#if DEVEL == 1
    luaL_dofile(L,"maps.lua");
    luaL_dofile(L,"snek.lua");
    luaL_dofile(L,"main.lua");
    luaL_dofile(L,"position.lua");
#else
    luaL_dofile(L,"/usr/local/share/snek/maps.luac");
    luaL_dofile(L,"/usr/local/share/snek/snek.luac");
    luaL_dofile(L,"/usr/local/share/snek/main.luac");
    luaL_dofile(L,"/usr/local/share/snek/position.luac");
#endif

    //Starting the main lua function
    lua_getglobal(L,"main");
    lua_call(L,0,0);

    //Cleanup
    lua_close(L);

    return 0;
}
