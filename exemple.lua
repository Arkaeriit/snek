
function main()
    initscr()
    curs_set(0)
    start_color()
    local y,x = getmaxyx()
    x = (x - x%2)/2 - 7
    y = (y - y%2)/2 
    mvprintw(y,x,"Hello, world!")
    refresh()
    os.execute("sleep 5")
    endwin()
end

--setlocale(LC_ALL, "")
