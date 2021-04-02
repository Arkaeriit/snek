#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <stdio.h>
#include <dirent.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

//Internal functions
/*static int gFS_exist(const char* fileName){
    return (access( fileName, F_OK ) != -1);
}*/


static mode_t gFS_getPerm(const char* fileName){
    struct stat buffer;
    stat(fileName, &buffer);
    return buffer.st_mode;
}

//Lua function

static int gFS_ls(lua_State* L){
    const char* dirName = luaL_checkstring(L,1);
    DIR *dirDesc;
    struct dirent *dirEntry;
    dirDesc = opendir(dirName);
    lua_createtable(L,25,0); //Creating of a table, we assume the existence of 25 elements but this is a very basic estimation
    int index = 0; //The index of each element in the table
    if(dirDesc){ //The directory exists
        while((dirEntry = readdir(dirDesc)) != NULL){
            char* currentfile = dirEntry->d_name;
            if( (strcmp(currentfile,".")) && (strcmp(currentfile,".."))){
                index++;
                lua_pushinteger(L,index);
                lua_pushstring(L,currentfile);
                lua_settable(L,-3); 
            }
        }
    }
    /* The table is already on top of the stack */
    return 1;
}

static int gFS_mkdir(lua_State *L){
    const char* dirName = luaL_checkstring(L,1);
    mkdir(dirName,755);
    return 0;
}

static int gFS_isDir(const char* fileName){
    struct stat statFichier;
    stat(fileName,&statFichier);
    return S_ISDIR(statFichier.st_mode);
}

static int gFS_isDir_lua(lua_State *L){
    const char* fileName = luaL_checkstring(L,1);
    lua_pushboolean(L,gFS_isDir(fileName));
    return 1;
}

static int gFS_rm(lua_State *L){
    const char* fileName = luaL_checkstring(L,1);
    unlink(fileName);
    return 0;
}

static int gFS_getPermLua(lua_State *L){
    const char* fileName = luaL_checkstring(L, 1);
    mode_t ret = gFS_getPerm(fileName);
    lua_pushinteger(L, ret);
    return 1;
}

static int gFS_chmod(lua_State *L){
    const char* fileName = luaL_checkstring(L, 1);
    mode_t mode = luaL_checkinteger(L, 2);
    chmod(fileName, mode);
    return 0;
}

static int gFS_fileSize(lua_State* L){
    const char* fileName = luaL_checkstring(L,1);
    FILE* descripteurFile;
    descripteurFile = fopen(fileName,"r");
    fseek(descripteurFile,0,SEEK_END);
    long size = ftell(descripteurFile);
    fclose(descripteurFile);
    lua_pushinteger(L,size);
    return 1;
}

//Inclusion

static const struct luaL_Reg gestionFS [] = {
    {"ls", gFS_ls},
    {"createDir", gFS_mkdir},
    {"isDir", gFS_isDir_lua},
    {"rm", gFS_rm},
    {"getPerm", gFS_getPermLua},
    {"chmod", gFS_chmod},
    {"fileSize", gFS_fileSize},
    {NULL, NULL}
};

int luaopen_gestionFS(lua_State* L){
    luaL_newlib(L, gestionFS);
    return 1;
}

