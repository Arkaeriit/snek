//exemple d'appel de fonctions lua par du C


#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include "cursedLua.h"
#include "luaSleep.h"

int main(){
    lua_State* L;
    // initialize Lua interpreter
    L = luaL_newstate();

    // load Lua base libraries (print / math / etc)
    luaL_openlibs(L);

    //On charge les fonctions custom
    cl_include(L);
    lS_include(L);

    //On charge le fichier
    luaL_dofile(L,"maps.lua");
    luaL_dofile(L,"snek.lua");
    luaL_dofile(L,"main.lua");
    luaL_dofile(L,"position.lua");

    //On appelle la fonction
    lua_getglobal(L,"main");

    //On execute la fonction
    lua_call(L,0,0);

    // Cleanup:  Deallocate all space assocatated with the lua state */
    lua_close(L);

    return 0;
}
