--[[
This file is used to generate maps from a file.
A map file is started by a line that will not be parsed to give it a description.
The second line contain a number, the number of fruit that need to be put in the map
The third line contain the number of the line where the snake start.
The fourth line contain the number of the collumn where the snake start. Note that the snake goes to it's right when starting and it got a 1 tile long tail.
Then each line contain what is needed to represent ehe content of the map, each line of the file represent a line of the map. Each char in the file correspond to an object with the same id on the map.
New lines, cardrige return are not parsed, unknown character are considered as void tiles.
]]

--dictionary
dico = { ["0"] = void,
         ["1"] = ground,
         ["2"] = wall,
         ["3"] = head,
         ["4"]  = body,
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

--Read a file whose pointer in given as argument and return the corresponding map
function readMap(file)
    local str = file:read("l")
    local fruit = tonumber(file:read("l"))
    local y = tonumber(file:read("l"))
    local x = tonumber(file:read("l"))
    local sn = createSnek(y, x)
    sn.body = {pos(y, x-1)}
    local ret = map(sn)
    str = file:read("l")
    while str do
        ret[#ret+1] = createLine(str)
        str = file:read("l")
    end
    for i=1,#fruit do
        ret:addFruit()
    end
    return ret
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




