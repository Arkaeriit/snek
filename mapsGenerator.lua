--[[
This file is used to generate maps from a file.
A map file is started by a line that will not be parsed to give it a description.
The second line contain a number, the number of fruit that need to be put in the map
The third line contain the number of the line where the snake start.
The fourth line contain the number of the collumn where the snake start. Note that the snake goes to it's right when starting and it got a 1 tile long tail.
The fifth line contain the size of the snake expected to wil. If it is not a number it will default to the number of ground tiles.
Then each line contain what is needed to represent ehe content of the map, each line of the file represent a line of the map. Each char in the file correspond to an object with the same id on the map.
New lines, cardrige return are not parsed, unknown character are considered as void tiles.
]]

--dictionary
dico = { ["0"] = void,
         ["1"] = ground,
         ["2"] = wall,
         --["3"] = head,  --No point in using the head or the body as tiles
         --["4"]  = body,
         ["5"] = fruit,
}

--Test if the dico is properly loaded
function testLoad()
    local count = 0
    for k,v in pairs(dico) do
        if k ~= tostring(v.id) then
            io.stderr:write("Error while loading dico.\n")
            return -50
        end
        count = count+1
    end
    if count <= 1 then
        io.stderr:write("Error while loading dico.\n")
        return -50
    end
    return 0
end

--Read a file whose pointer in given as argument and return the corresponding map. If there is an error it retuen an explication as a second argument
function readMap(file)
    local str = file:read("l") --comment line
    local fruit = tonumber(file:read("l")) --parsing of the firsts parametters
    local y = tonumber(file:read("l"))
    local x = tonumber(file:read("l"))
    local max = tonumber(file:read("l"))
    if errorInput(fruit, x, y, max) then --checking the validity of the first parametters
        return nil,"Error : the 4 first parameters of the map are wrong.\n"
    end
    local sn = createSnek(math.tointeger(y), math.tointeger(x)) --creation of the snake
    sn.body = {pos(math.tointeger(y), math.tointeger(x)-1)}
    local ret = map(sn, fruit)
    str = file:read("l")
    while str do --creation of the map
        ret[#ret+1] = createLine(str)
        str = file:read("l")
    end
    if max and math.tointeger(max) then
        ret.max = math.tointeger(max)
    else
        ret:setMaxGnd()
    end
    if errorPosition(ret) then --checking the position of the snake
        return nil, "Error : the snake is outside the map.\n"
    end
    ret:fillFruits()
    return ret, nil
end

--check that the 4 first parameters are integers
function errorInput(fruit, x, y ,max)
    return not (fruit and math.tointeger(fruit) and x and math.tointeger(x) and y and math.tointeger(y))
end

--check that the snake is inside the map
function errorPosition(map)
    local x = map.snek.head.x
    local y = map.snek.head.y
    if x < 2 or y < 1 then --we check the small bound
        return true
    end
    if y > #map or x > #map[y] then --we check that the snake is inside the map
        return true
    end
    return map[y][x] == wall or map[y][x-1] == wall --we check that the snake is not on walls
end

--Take a line from a file and create a line for a map, then return it
function createLine(str)
    local ret = {}
    for i=1,#str do
        local cnv = dico[str:sub(i,i)]
        if cnv then
            ret[#ret+1] = cnv
        elseif str:sub(i,i) ~= '\r' then
            ret[#ret+1] = void
        end
    end
    return ret
end




