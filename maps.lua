--[[
This file contain what is needed to generate the map or read it from
a text file and to display it.
]]

--[[the map is represeted as a 2 dimention array
The possible elements are :
    void : a case not in the arena, no fruits can go there
    ground : nothing on the case
    wall : a wall on the case
    head : the head of the snek
    body : the body of the snek
    fruit : the fruits the snek can eat
Each element got an ID, a color palette and a representing character
]]

--[[
Deyond the tiles a map contain a reference to a snek on the map and a
number, max, wich represent the max size the snake can grow
]]

--definitions
void = {id = 0, color = 1, char = " "}
ground = {id = 1, color = 1, char = " "}
wall = {id = 2, color = 2, char = " "}
head = {id = 3, color = 3, char = "@"}
body = {id = 4, color = 3, char = "+"}
fruit = {id = 5, color = 4, char = "o"}

--generate the most boring map you can think of
function rectangleMap(snek, y, x)
    local ret = map(snek)
    for i=1,y do
        ret[i] = {}
        for j=1,x do
            if i==1 or j==1 or j==x or i==y then
                ret[i][j] = wall
            else
                ret[i][j] = ground
            end
        end
    end
    ret:setMaxGnd()
    return ret
end



--a basic map class
function map(snek)
    local ret = {["snek"] = snek, ["max"] = 0}

    --refresh the screen
    ret.show = function(map)
        map:drawMap()
        map.snek:show()
        nc.refresh()
    end

    --return weather or not the head of the snek is on a fruit and if true hange the case back to normal ground
    ret.yum = function(map)
        if map[map.snek.head.y][map.snek.head.x] == fruit then
            map[map.snek.head.y][map.snek.head.x] = ground
            return true
        else
            return false
        end        
    end

    --draw a map a tad to the top left of the terminal
    ret.drawMap = function(map)
        for i=1,#map do
            nc.move(i+offset-1, offset)
            for j=1,#map[i] do
                local case = map[i][j]
                nc.set_color(case.color)
                nc.printw(case.char)
            end
        end
    end

    --chack if the snek in the map is bumping it's head against a wall
    ret.isBumping = function(map)
        return map[map.snek.head.y][map.snek.head.x] == wall
    end

    --change a ground case not bellow the snek in a fruit case
    ret.addFruit = function(map)
        local groundMap = map:freeGround()
        if #groundMap > 0 then
            local i = math.random(1, #groundMap)
            map[groundMap[i].y][groundMap[i].x] = fruit
        end
    end

    --put the number of ground tiles in the max fied
    ret.setMaxGnd = function(map)   
        map.max = map:cmpGround()
    end

    --return the number of ground tiles
    ret.cmpGround = function(map)
        local ret = 0
        for i=1,#map do
            for j=1,#map[i] do
                if map[i][j] == ground then
                    ret = ret + 1
                end
            end
        end
        return ret
    end

    --return a list of free grong tiles
    ret.freeGround = function(map)
        local ret = {}
        for i=1,#map do
            for j=1,#map[i] do
                if map[i][j] == ground then
                    if not map.snek:isSnek(pos(i, j)) then
                        ret[#ret+1] = pos(i,j)
                    end
                end
            end
        end
        return ret
    end


    --return true if the size of the snake is equal to the max field
    ret.isWin = function(map)
        return (#map.snek.body + 1) >= map.max
    end

    return ret
end

