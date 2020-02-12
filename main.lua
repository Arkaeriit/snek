
function initcurses()
    initscr()
    curs_set(0)
    start_color()
    use_default_colors()
    init_pair(1,-1,-1)
    init_pair(2,1,15)
    offset = 2
end

function main()
    initcurses()
    local mapTest = rectangleMap(8,12)
    sn = createSnek(4,4)
    sn.body = {{y=4,x=3},{y=4,x=2},{y=3,x=2}}
    mapTest:show()
    sn:show()
    refresh()
    sleep(20)
    endwin()
end

