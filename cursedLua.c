
#include <ncurses.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <locale.h>
#include <unistd.h>

static int cl_init(lua_State *L){
    setlocale(LC_ALL,"");
    newterm(NULL,NULL,stdout); //on utilise cela si on veux que le programme vienne d'un pipe
    return 0;
}

static int cl_echo(lua_State *L){
    echo();
    return 0;
}

static int cl_noecho(lua_State *L){
    noecho();
    return 0;
}

static int cl_close(lua_State *L){
    endwin();
    return 0;
}

static int cl_cursset(lua_State *L){
    int s = luaL_checknumber(L,1);
    if( (s==0) | (s==1) | (s==2) ) curs_set(s);
    return 0;
}

static int cl_refresh(lua_State *L){
    refresh();
    return 0;
}

static int cl_getxy(lua_State *L){
    int x;
    int y;
    getmaxyx(stdscr,y,x);
    lua_pushnumber(L,y);
    lua_pushnumber(L,x);
    return 2;
}

static int cl_getch(lua_State *L){
    fseek(stdin,0,SEEK_END);
    keypad(stdscr,TRUE);
    int elem = getch();
    lua_pushinteger(L,elem);
    return 1;
}

static int cl_hascolor(lua_State *L){
    lua_pushboolean(L,has_colors());
    return 1;
}

static int cl_startcolor(lua_State *L){
    start_color();
    return 0;
}

static int cl_defaultcolors(lua_State *L){
    use_default_colors();
    return 0;
}

static int cl_init_pair(lua_State *L){
    int couleur2 = luaL_checknumber(L,3);
    int couleur1 = luaL_checknumber(L,2);
    int paire = luaL_checknumber(L,1);
    init_pair(paire,couleur1,couleur2);
    return 0;
}

static int cl_printw(lua_State* L){
    const char* str = luaL_checkstring(L,1);
    printw("%s",str);
    return 0;
}

static int cl_mvprintw(lua_State *L){
    const char* str = luaL_checkstring(L,3);
    int x = luaL_checknumber(L,2);
    int y = luaL_checknumber(L,1);
    mvprintw(y,x,"%s",str);
    return 0;
}

static int cl_move(lua_State* L){
    int x = luaL_checknumber(L,2);
    int y = luaL_checknumber(L,1);
    move(y,x);
    return 0;
}

static int cl_colors(lua_State *L){
    int color2 = luaL_checknumber(L,2);
    int color1 = luaL_checknumber(L,1);
    use_default_colors();
    if(has_colors()){
        init_pair(1,color1,color2);
        wbkgd(stdscr,COLOR_PAIR(1));
    }
    return 0;
}

static int cl_set_color(lua_State *L){
    int paire = luaL_checknumber(L,1);
    attron(COLOR_PAIR(paire));
    return 0;
}

static int cl_getchTime(lua_State* L){
    int scale = luaL_checkinteger(L,2);
    int timeout = luaL_checkinteger(L,1);
    int ret;
    nodelay(stdscr, TRUE);
    for(int i=0;i<timeout;i+=scale){
        usleep(scale);
        ret = getch();
        if(ret != -1) //If we entered a char we stop
            break;
        usleep(scale);
    }
    nodelay(stdscr, FALSE);
    printf("%i %i\n",KEY_DOWN,ret);
    lua_pushinteger(L,ret);
    return 1;
}

static int cl_nodelay(lua_State* L){
    int flag = lua_toboolean(L,0);
    nodelay(stdscr, flag);
    return 0;
}

static const struct luaL_Reg cursedLua [] = {
    {"initscr", cl_init},
    {"endwin", cl_close},
    {"curs_set", cl_cursset},
    {"printw", cl_printw},
    {"mvprintw", cl_mvprintw},
    {"move", cl_move},
    {"getmaxyx", cl_getxy},
    {"getch", cl_getch},
    {"echo", cl_echo},
    {"noecho", cl_noecho},
    {"has_colors", cl_hascolor},
    {"cl_colors", cl_colors},
    {"start_color", cl_startcolor},
    {"use_default_colors", cl_defaultcolors},
    {"init_pair", cl_init_pair},
    {"cl_getchTime", cl_getchTime},
    {"nodelay", cl_nodelay},
    {"refresh", cl_refresh},
    {"set_color", cl_set_color},
    {NULL, NULL}
};


int luaopen_cursedLua(lua_State *L){
    //loading functions
    luaL_newlib(L, cursedLua);
    //Setting special symbols
    lua_pushstring(L ,"KEY_ENTER");
    lua_pushinteger(L ,KEY_ENTER);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_BACKSPACE"); 
    lua_pushinteger(L ,KEY_BACKSPACE);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_UP"); 
    lua_pushinteger(L ,KEY_UP);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_DOWN"); 
    lua_pushinteger(L ,KEY_DOWN);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_LEFT"); 
    lua_pushinteger(L ,KEY_LEFT);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_RIGHT"); 
    lua_pushinteger(L ,KEY_RIGHT);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_HOME"); 
    lua_pushinteger(L ,KEY_HOME);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_END"); 
    lua_pushinteger(L ,KEY_END);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_NPAGE"); 
    lua_pushinteger(L ,KEY_NPAGE);
    lua_settable(L, -3);
    lua_pushstring(L ,"KEY_PPAGE"); 
    lua_pushinteger(L ,KEY_PPAGE);
    lua_settable(L, -3);
    return 1;
}

