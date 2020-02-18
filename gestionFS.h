/*-----------------------------------------------------------\
|Ces fonctions permettent au script lua d'intéragir propement|
|avec les système de fichiers. Ces fonctions sont faites pour|
fonctionner avec des systèmes POSIX.                         |
\-----------------------------------------------------------*/

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
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

void gFS_include(lua_State *L);

int gFS_exist(const char* fileName); //indique si un fichier existe ou non.
