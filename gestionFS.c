#include "gestionFS.h"

int gFS_ls(lua_State* L){
    const char* dirName = luaL_checkstring(L,1);
    DIR *dirDesc;
    struct dirent *dirEntry;
    dirDesc = opendir(dirName);
    lua_createtable(L,25,0); //On créé une table, on pese qu'il y aura environt 25élem mais c'est une approximation assez vulgaire.
    int index = 0; //sert à indéxer la table
    if(dirDesc){ //Le dossier existe
        while((dirEntry = readdir(dirDesc)) != NULL){
            char* currentfile = dirEntry->d_name;
            if( (strcmp(currentfile,".")) && (strcmp(currentfile,".."))){
                index++;
                lua_pushinteger(L,index);
                lua_pushstring(L,currentfile);
                lua_settable(L,-3); //On met le fichier dans la tale à l'index index.
            }
        }
    }
    /* La table est déja au sommet de la stack */
    return 1;
}

int gFS_mkdir(lua_State *L){
    const char* dirName = luaL_checkstring(L,1);
    mkdir(dirName,755);
    return 0;
}

int gFS_isDir(const char* fileName){
    struct stat statFichier;
    stat(fileName,&statFichier);
    return S_ISDIR(statFichier.st_mode);
}

int gFS_isDir_lua(lua_State *L){
    const char* fileName = luaL_checkstring(L,1);
    lua_pushboolean(L,gFS_isDir(fileName));
    return 1;
}

int gFS_rm(lua_State *L){
    const char* fileName = luaL_checkstring(L,1);
    unlink(fileName);
    return 0;
}

int gFS_getPermLua(lua_State *L){
    const char* fileName = luaL_checkstring(L, 1);
    mode_t ret = gFS_getPerm(fileName);
    lua_pushinteger(L, ret);
    return 1;
}

int gFS_chmod(lua_State *L){
    const char* fileName = luaL_checkstring(L, 1);
    mode_t mode = luaL_checkinteger(L, 2);
    chmod(fileName, mode);
    return 0;
}

int fileSize(lua_State* L){
    const char* fileName = luaL_checkstring(L,1);
    FILE* descripteurFile;
    descripteurFile = fopen(fileName,"r");
    fseek(descripteurFile,0,SEEK_END);
    long size = ftell(descripteurFile);
    fclose(descripteurFile);
    lua_pushinteger(L,size);
    return 1;
}


void gFS_include(lua_State* L){
    lua_pushcfunction(L,gFS_ls);
    lua_setglobal(L,"ls");
    lua_pushcfunction(L,gFS_mkdir);
    lua_setglobal(L,"createDir");
    lua_pushcfunction(L,gFS_isDir_lua);
    lua_setglobal(L,"isDir");
    lua_pushcfunction(L,gFS_rm);
    lua_setglobal(L,"rm");
    lua_pushcfunction(L,gFS_getPermLua);
    lua_setglobal(L,"getPerm");
    lua_pushcfunction(L,gFS_chmod);
    lua_setglobal(L,"chmod");
    lua_pushcfunction(L,fileSize);
    lua_setglobal(L,"fileSize");
}



int gFS_exist(const char* fileName){
    return (access( fileName, F_OK ) != -1);
}

mode_t gFS_getPerm(const char* fileName){
    struct stat buffer;
    stat(fileName, &buffer);
    return buffer.st_mode;
}

