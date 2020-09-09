/*-----------------------------------------------------------\
|Ces fonctions permettent au script lua d'intéragir propement|
|avec les système de fichiers. Ces fonctions sont faites pour|
|fonctionner avec des systèmes POSIX.                        |
\-----------------------------------------------------------*/

#ifndef GESTIONFS_LUA
#define GESTIONFS_LUA

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

int gFS_ls(lua_State* L); //permet d'avoir le ls en lua
int gFS_mkdir(lua_State* L); //permet d'avoir le mkdir en lua
int gFS_isDir(const char* fileName); //indique si fileName existe
int gFS_isDir_lua(lua_State* L); //permet de savoir si un fichier est un dossier ou non
int gFS_rm(lua_State* L); //permet de supprimer un fichier
int gFS_getPermLua(lua_State* L); //warper autour de getPerm
int gFS_chmod(lua_State* L); //converti chmod en lua
int fileSize(lua_State* L); //Permet de savoir en lua la taille d'un fichier

void gFS_include(lua_State *L);

int gFS_exist(const char* fileName); //indique si un fichier existe ou non.
mode_t gFS_getPerm(const char* fileName); //Retourne les permitions d'un fihier

#endif

