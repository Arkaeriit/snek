--[[
This file contain the function to show the snake
The snake is represented by a list of all the cases its body is on
and by the position of its head
The cases in the body are represented by the relative position of 
each case from the previous one
    1
   2 4
    3
]]

function createSnek(x, y)
    local ret = {head = {y,x}, body={}}

    ret.show = function(snek)
        local pos = snek.head
        set_color(head.color)
        mvprintw(offset + pos[1], offset + pos[2], head.char)
        if not caseSnek then --definition of the switch statement regarding the drawing of the snake
            caseSnek = {
                [1] = function(pos); pos[1] = pos[1] - 1; end,
                [2] = function(pos); pos[2] = pos[2] - 1; end,
                [3] = function(pos); pos[1] = pos[1] + 1; end,
                [4] = function(pos); pos[2] = pos[2] + 1; end
            }
        end
        for i=1,#snek.body do
            set_color(body.color)
            caseSnek[snek.body[i]](pos)
            mvprintw(offset + pos[1], offset + pos[2], body.char)
        end
    end

    return ret
end

