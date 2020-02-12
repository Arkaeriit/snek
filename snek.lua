--[[
This file contain the function to show the snake
The snake is represented by a list of all the cases its body is on
and by the position of its head
The cases in the body are represented by their obsolute position
Dirrection from the head is when moving is showed like that:
    1
   2 4
    3
]]

function createSnek(x, y)
    local ret = {head = {["y"] = y,["x"] = x}, body={}}

    ret.show = function(snek)
        set_color(head.color)
        mvprintw(offset + snek.head.y, offset + snek.head.x, head.char)
        for i=1,#snek.body do
            set_color(body.color)
            mvprintw(offset + snek.body[i].y, offset + snek.body[i].x, body.char)
        end
    end

    --the dirrection is relative to the head as defined in the begining of the fine, growth is a bool asking if the snake moved or just grow.
    --ret.move = function(direction, growth) 

    return ret
end

