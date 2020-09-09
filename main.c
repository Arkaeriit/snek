/*--------------------------------------------\
This file is used to start the Lua program and|
load lirairies and luac files.                |
\--------------------------------------------*/

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include "luaSleep.h"
#include "gestionFS.h"

//Choosing local file or global ones
#define DEVEL 1

int main(int argc, char** argv){
    lua_State* L;
    L = luaL_newstate();

    //Loading librairies
    luaL_openlibs(L);
    lS_include(L);
    gFS_include(L);

    //Loading lua files
#if DEVEL == 1
    luaL_dofile(L,"maps.lua");
    luaL_dofile(L,"snek.lua");
    luaL_dofile(L,"main.lua");
    luaL_dofile(L,"position.lua");
    luaL_dofile(L,"mapsGenerator.lua");
    luaL_dofile(L,"info.lua");
#else
    luaL_dofile(L,"/usr/share/snek/maps.luac");
    luaL_dofile(L,"/usr/share/snek/snek.luac");
    luaL_dofile(L,"/usr/share/snek/main.luac");
    luaL_dofile(L,"/usr/share/snek/position.luac");
    luaL_dofile(L,"/usr/share/snek/mapsGenerator.luac");
    luaL_dofile(L,"/usr/share/snek/info.luac");
    luaL_dofile(L,"/usr/local/share/snek/maps.luac");
    luaL_dofile(L,"/usr/local/share/snek/snek.luac");
    luaL_dofile(L,"/usr/local/share/snek/main.luac");
    luaL_dofile(L,"/usr/local/share/snek/position.luac");
    luaL_dofile(L,"/usr/local/share/snek/mapsGenerator.luac");
    luaL_dofile(L,"/usr/local/share/snek/info.luac");
#endif

    //Starting the main lua function
    if(argc == 1){ //no arguments
        lua_getglobal(L,"defaultPlay");
        lua_call(L,0,1);
    }else if(argc == 2){ //one argument
        if(!strcmp(argv[1],"help")){
            lua_getglobal(L,"help");
            lua_call(L,0,1);
        }else if(!strcmp(argv[1],"map")){
            lua_getglobal(L,"displayAvailableMaps");
            lua_call(L,0,1);
        }else{ //We ask a special map
            lua_getglobal(L,"askMap");
            lua_pushstring(L, argv[1]);
            lua_call(L,1,1);
        }
    }else{ //Bad arguments
        lua_getglobal(L,"invalidArgs");
        lua_call(L,0,1);
    }
    int ret = luaL_checknumber(L,-1);

    //Cleanup
    lua_close(L);

    return ret;
}

