
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
    local mapTest = rectangleMap(8,12)
    sn = createSnek(4,4)
    sn.body = {2,2,3}
    drawMap(mapTest,2)
    sn:show(2)
    refresh()
    sleep(20)
    endwin()
end

