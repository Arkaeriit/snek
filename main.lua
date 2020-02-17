
function initcurses()
    log = io.open("log","a") --a debug file
    log:write("\nNew Game\n")
    initscr()
    curs_set(0)
    start_color()
    noecho()
    use_default_colors()
    init_pair(1,-1,-1)
    init_pair(2,1,15)
    offset = 2
end

function input()
    ch = getch()
    if not swichInput then
        swichInput = {
            [KEY_UP] = 1,
            [KEY_LEFT] = 2,
            [KEY_DOWN] = 3,
            [KEY_RIGHT] = 4,
        }
    end
    return swichInput[ch]
end

function gameLoop(map)
    nodelay(true)
    map:addFruit()
    previousDir = 1
    while not fin do
        inp = input()
        if inp and inp ~= previousDir then
            map.snek:move(inp)
            previousDir = inp
        else
            map.snek:move(previousDir)
        end
        if map:yum() then --if the snake ate a fruit we put a new one otherwise we prevent the snek from growing
            map:addFruit()
        else
            map.snek:cut()
        end
        map:show()
        collectgarbage() --a good time to collect since there is nothing to do
        msleep(500)
        if map:isBumping() or map.snek:biting() then
            fin = true
        end
    end
    nodelay(false);
end

function main()
    sn = createSnek(4,4)
    local mapTest = rectangleMap(sn,8,12)
    sn.body = {pos(4,3),pos(4,2),pos(3,2),pos(2,2)}

    initcurses()
    mapTest:show()
    gameLoop(mapTest)
    sleep(5)
    endwin()
end

