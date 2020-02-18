
function initcurses()
    --log = io.open("log","a") --a debug file --not much point now
    --log:write("\nNew Game\n")
    initscr()
    curs_set(0)
    start_color()
    noecho()
    use_default_colors()
    init_pair(1,-1,-1)
    init_pair(2,1,15)
    init_pair(3,10,-1)
    init_pair(4,9,-1)
    if not offset then --we give offset a default value
        offset = 2
    end
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
    local previousDir = 4 --at the start the snake go to the right
    map:show()
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
        if map:isBumping() or map.snek:biting() or map:isWin() then
            fin = true
        end
    end
    nodelay(false);
end

--generate a default map whose size is based on the size of the terminal
--if the map can't be generated an error is returned as a second return value
function defaltMap()
    initcurses()
    local y,x = getmaxyx()
    if y < 10 or x < 9 then
        return nil,"Error : terminal too small"
    end
    local sn = createSnek(2,3)
    sn.body = {pos(2,2)}
    local ret = rectangleMap(sn, y-6, x-6)
    for i=1,math.ceil(ret.max/12) do --we add a fruit for each 12 tiles
        ret:addFruit()
    end
    offset = 3
    return ret
end

function playMap(map)
    math.randomseed(os.time())
    initcurses()
    gameLoop(map)
    sleep(3)
    endwin()
    if map:isWin() then
        print("You won!")
    else
        print("You lost.")
    end
    return 0
end

function defaultPlay()
    local map,err = defaltMap()
    if err then
        endwin()
        io.stderr:write(err)
        return 1
    end
    local ret = playMap(map)
    return ret
end

function askMap(filename)
    local f = io.open(filename,"r")
    if not f then
        f = io.open("/usr/local/share/snek/maps/"..filename,"r")
    end
    if not f then
        f = io.open("/usr/share/snek/maps/"..filename,"r")
    end
    if not f then
        io.stderr:write("Errot : No such map as ",filename,".\n")
        return 3
    end
    local map,err = readMap(f)
    if err then
        io.stderr:write(err)
        return 2
    end
    playMap(map)
    return 0
end

