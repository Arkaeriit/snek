
#include "cursedLua.h"

int cl_init(lua_State *L){
    setlocale(LC_ALL,"");
    newterm(NULL,NULL,stdout); //on utilise cela si on veux que le programme vienne d'un pipe
    return 0;
}

int cl_echo(lua_State *L){
    echo();
    return 0;
}

int cl_noecho(lua_State *L){
    noecho();
    return 0;
}

int cl_close(lua_State *L){
    endwin();
    return 0;
}

int cl_cursset(lua_State *L){
    int s = luaL_checknumber(L,1);
    if( (s==0) | (s==1) | (s==2) ) curs_set(s);
    return 0;
}

int cl_refresh(lua_State *L){
    refresh();
    return 0;
}

int cl_getxy(lua_State *L){
    int x;
    int y;
    getmaxyx(stdscr,y,x);
    lua_pushnumber(L,y);
    lua_pushnumber(L,x);
    return 2;
}

int cl_getch(lua_State *L){
    fseek(stdin,0,SEEK_END);
    keypad(stdscr,TRUE);
    int elem = getch();
    lua_pushinteger(L,elem);
    return 1;
}

int cl_hascolor(lua_State *L){
    lua_pushboolean(L,has_colors());
    return 1;
}

int cl_startcolor(lua_State *L){
    start_color();
    return 0;
}

int cl_defaultcolors(lua_State *L){
    use_default_colors();
    return 0;
}

int cl_init_pair(lua_State *L){
    int couleur2 = luaL_checknumber(L,3);
    int couleur1 = luaL_checknumber(L,2);
    int paire = luaL_checknumber(L,1);
    init_pair(paire,couleur1,couleur2);
    return 0;
}

int cl_printw(lua_State* L){
    const char* str = luaL_checkstring(L,1);
    printw("%s",str);
    return 0;
}

int cl_mvprintw(lua_State *L){
    const char* str = luaL_checkstring(L,3);
    int x = luaL_checknumber(L,2);
    int y = luaL_checknumber(L,1);
    mvprintw(y,x,"%s",str);
    return 0;
}

int cl_move(lua_State* L){
    int x = luaL_checknumber(L,2);
    int y = luaL_checknumber(L,1);
    move(y,x);
    return 0;
}

int cl_colors(lua_State *L){
    int color2 = luaL_checknumber(L,2);
    int color1 = luaL_checknumber(L,1);
    use_default_colors();
    if(has_colors()){
        init_pair(1,color1,color2);
        wbkgd(stdscr,COLOR_PAIR(1));
    }
    return 0;
}

int cl_set_color(lua_State *L){
    int paire = luaL_checknumber(L,1);
    attron(COLOR_PAIR(paire));
    return 0;
}

int cl_getchTime(lua_State* L){
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

int cl_nodelay(lua_State* L){
    int flag = lua_toboolean(L,0);
    nodelay(stdscr, flag);
    return 0;
}

void cl_include(lua_State *L){
    lua_pushcfunction(L,cl_init);
    lua_setglobal(L,"initscr");
    lua_pushcfunction(L,cl_close);
    lua_setglobal(L,"endwin");
    lua_pushcfunction(L,cl_cursset);
    lua_setglobal(L,"curs_set");
    lua_pushcfunction(L,cl_printw);
    lua_setglobal(L,"printw");
    lua_pushcfunction(L,cl_mvprintw);
    lua_setglobal(L,"mvprintw");
    lua_pushcfunction(L,cl_move);
    lua_setglobal(L,"move");
    lua_pushcfunction(L,cl_refresh);
    lua_setglobal(L,"refresh");
    lua_pushcfunction(L,cl_getxy);
    lua_setglobal(L,"getmaxyx");
    lua_pushcfunction(L,cl_getch);
    lua_setglobal(L,"getch");
    lua_pushcfunction(L,cl_echo);
    lua_setglobal(L,"echo");
    lua_pushcfunction(L,cl_noecho);
    lua_setglobal(L,"noecho");
    lua_pushcfunction(L,cl_hascolor);
    lua_setglobal(L,"has_colors");
    lua_pushcfunction(L,cl_colors);
    lua_setglobal(L,"cl_color");
    lua_pushcfunction(L,cl_startcolor);
    lua_setglobal(L,"start_color");
    lua_pushcfunction(L,cl_defaultcolors);
    lua_setglobal(L,"use_default_colors");
    lua_pushcfunction(L,cl_init_pair);
    lua_setglobal(L,"init_pair");
    lua_pushcfunction(L,cl_set_color);
    lua_setglobal(L,"set_color");
    lua_pushcfunction(L,cl_getchTime);
    lua_setglobal(L,"getchTime");
    lua_pushcfunction(L,cl_nodelay);
    lua_setglobal(L,"nodelay");

    //Définition de caractères spréciaux
    lua_pushinteger(L,KEY_ENTER);
    lua_setglobal(L,"KEY_ENTER");
    lua_pushinteger(L,KEY_BACKSPACE);
    lua_setglobal(L,"KEY_BACKSPACE"); 
    lua_pushinteger(L,KEY_UP);
    lua_setglobal(L,"KEY_UP"); 
    lua_pushinteger(L,KEY_DOWN);
    lua_setglobal(L,"KEY_DOWN"); 
    lua_pushinteger(L,KEY_LEFT);
    lua_setglobal(L,"KEY_LEFT"); 
    lua_pushinteger(L,KEY_RIGHT);
    lua_setglobal(L,"KEY_RIGHT"); 
    lua_pushinteger(L,KEY_HOME);
    lua_setglobal(L,"KEY_HOME"); 
    lua_pushinteger(L,KEY_END);
    lua_setglobal(L,"KEY_END"); 
    lua_pushinteger(L,KEY_NPAGE);
    lua_setglobal(L,"KEY_NPAGE"); 
    lua_pushinteger(L,KEY_PPAGE);
    lua_setglobal(L,"KEY_PPAGE"); 
}



