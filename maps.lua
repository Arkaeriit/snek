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

--definitions
void = {id = 0, color = 1, char = " "}
ground = {id = 1, color = 1, char = " "}
wall = {id = 2, color = 2, char = " "}
head = {id = 3, color = 1, char = "@"}
body = {id = 4, color = 1, char = "+"}
fruit = {id = 5, color = 1, char = "o"}

--generate the most boring map you can think of
function rectangleMap(snek, x, y)
    local ret = map(snek)
    for i=1,x do
        ret[i] = {}
        for j=1,y do
            if i==1 or j==1 or i==x or j==y then
                ret[i][j] = wall
            else
                ret[i][j] = ground
            end
        end
    end
    return ret
end

--draw a map a tad to the top left of the terminal
function drawMap(map)
    for i=1,#map do
        move(i+offset-1, offset)
        for j=1,#map[i] do
            local case = map[i][j]
            set_color(case.color)
            printw(case.char)
        end
    end
end

--chack if the snek in the map is bumping it's head against a wall
function isBumping(map)
    return map[map.snek.head.y][map.snek.head.x] == wall
end

--change a ground case not bellow the snek in a fruit case
function addFruit(map)
    y = math.random(1,#map)
    x = math.random(1,#map[y])
    if map[y][x] == ground and not map.snek:isSnek(x,y) then
        map[y][x] = fruit
    else --if we can't put a fruit we retry
        addFruit(map)
    end
end

--return weather or not the head of the snek is on a fruit and if true hange the case back to normal ground
function yum(map)
    if map[map.snek.head.y][map.snek.head.x] == fruit then
        map[map.snek.head.y][map.snek.head.x] = ground
        return true
    else
        return false
    end        
end

--a basic map class
function map(snek)
    local ret = {["snek"] = snek}
    ret.drawMap = drawMap
    ret.isBumping = isBumping
    ret.yum = yum
    ret.addFruit = addFruit

    --refresh the screen
    ret.show = function(map)
        map:drawMap()
        map.snek:show()
        refresh()
    end
    return ret
end


