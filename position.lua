--[[
This file contain a class used to represent a position on the board.
]]

function pos(y,x)
    local ret = {["x"] = x,["y"] = y}
    ret.clone = clone
    return ret
end

--clone pos2 into pos1
clone = function(pos1,pos2)
    pos1.x = pos2.x
    pos1.y = pos2.y
end


