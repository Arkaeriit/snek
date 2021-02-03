nc = require("cursedLua")
gFS = require("gestionFS")
curse_on = false --indicate if we run initcurses or not

function initcurses()
    math.randomseed(os.time())
    if not curse_on then
        --log = io.open("log","a") --a debug file --not much point now
        --log:write("\nNew Game\n")
        nc.initscr()
        nc.curs_set(0)
        nc.start_color()
        nc.noecho()
        nc.use_default_colors()
        nc.init_pair(1,-1,-1) --default color
        nc.init_pair(2,0,15) --wall color
        nc.init_pair(3,10,-1) --snake color
        nc.init_pair(4,9,-1) --fruit color
        if not offset then --we give offset a default value
            offset = 2
        end
        curse_on = true
    end
end

function stopcurses()
    if curse_on then
        nc.echo()
        nc.curs_set(1)
        nc.nodelay(false)
        nc.endwin()
        curse_on = false
    end
end

function input()
    local ch = nc.getch()
    if not swichInput then
        swichInput = {
            [nc.KEY_UP] = 1,
            [nc.KEY_LEFT] = 2,
            [nc.KEY_DOWN] = 3,
            [nc.KEY_RIGHT] = 4,
            [string.byte("p")] = "pause",
        }
    end
    return swichInput[ch]
end

function gameLoop(map)
    nc.nodelay(true)
    local previousDir = 4 --at the start the snake go to the right
    map:show()
    while not fin do
        local inp = input()
        if inp == "pause" then
            pause()
            inp = previousDir
        end
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
        if map.waitingFruits then --if we need to add more fuits then we should try to
            map:fillFruits()
        end
        msleep(500)
        if map:isBumping() or map.snek:biting() or map:isWin() then
            fin = true
        end
    end
    nc.nodelay(false);
end

-- A little pause promp
function pause()
    collectgarbage()
    nc.nodelay(false)
    local y,x = nc.getmaxyx()
    nc.set_color(2)
    nc.move(y-1, 1)
    nc.printw(" Game paused, press enter to resume. ")
    local inp = nc.getch()
    while inp ~= nc.KEY_ENTER and inp ~= 10 do
        inp = nc.getch()
        msleep(500)
    end
    nc.set_color(1)
    nc.move(y-1, 1)
    nc.printw("                                     ")
    nc.nodelay(true)
end

--generate a default map whose size is based on the size of the terminal
--if the map can't be generated an error is returned as a second return value
function defaultMap()
    initcurses()
    local y,x = nc.getmaxyx()
    if y < 10 or x < 9 then
        return nil,"Error : terminal too small"
    end
    local sn = createSnek(2,3)
    sn.body = {pos(2,2)}
    local ret = rectangleMap(sn, 0, y-6, x-6) --the amount of fruits will be added latter
    local fruits = math.ceil(ret.max/12) --we add a fruit for each 12 tiles
    ret.fruits = fruits
    ret:fillFruits()
    offset = 3
    return ret
end

function playMap(map)
    initcurses()
    gameLoop(map)
    sleep(3)
    stopcurses()
    if map:isWin() then
        print("You won!")
    else
        print("You lost.")
    end
    return 0
end

function defaultPlay()
    local map,err = defaultMap()
    if err then
        stopcurses()
        io.stderr:write(err)
        return 1
    end
    local ret = playMap(map)
    return ret
end

function askMap(filename)
    math.randomseed(os.time())
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
    local ret = playMap(map)
    return ret
end

