
function initcurses()
    initscr()
    curs_set(0)
    start_color()
    use_default_colors()
    init_pair(1,-1,-1)
    init_pair(2,1,15)
end

function main()
    initcurses()
    local mapTest = rectangleMap(3,7)
    drawMap(mapTest)
    refresh()
    sleep(10)
    endwin()
end

