#include "luaSleep.h"

int lS_usleep(lua_State* L){
    int time = luaL_checkinteger(L,1);
    usleep(time);
    return 0;
}

int lS_msleep(lua_State* L){
    int time = luaL_checkinteger(L,1);
    usleep(time * 1000);
    return 0;
}

int lS_sleep(lua_State* L){
    int time = luaL_checkinteger(L,1);
    usleep(time * 1000000);
    return 0;
}
void lS_include(lua_State* L){
    lua_pushcfunction(L,lS_usleep);
    lua_setglobal(L,"usleep");
    lua_pushcfunction(L,lS_msleep);
    lua_setglobal(L,"msleep");
    lua_pushcfunction(L,lS_sleep);
    lua_setglobal(L,"sleep");
}

