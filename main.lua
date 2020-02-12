
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
    getchTime(10000000,1000);
    sn = createSnek(4,4)
    local mapTest = rectangleMap(sn,8,12)
    sn.body = {pos(4,3),pos(4,2),pos(3,2)}
    mapTest:show()
    sleep(2)
    sn:move(1,false)
    mapTest:show()
    sleep(2)
    sn:move(2,true)
    mapTest:show()
    sleep(2)
    sn:move(1,false)
    mapTest:show()
    sleep(2)
    sn:move(4,false)
    mapTest:show()
    sleep(5)
    endwin()
end

