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
    local ret = {head = pos(x,y), body={}}

    ret.show = function(snek)
        set_color(head.color)
        mvprintw(offset + snek.head.y, offset + snek.head.x, head.char)
        for i=1,#snek.body do
            set_color(body.color)
            mvprintw(offset + snek.body[i].y, offset + snek.body[i].x, body.char)
        end
    end

    --the direction is relataive to the head as defined in the begining of the fine, growth is a bool asking if the snake moved or just grew.
    ret.move = function(snek, direction, growth) 
        snek.body[#snek.body+1] = pos(nil,nil) --all cases of the body are diplaced by one
        for i=0,#snek.body-2 do
            snek.body[#snek.body-i]:clone(snek.body[#snek.body-i-1])
        end
        snek.body[1]:clone(snek.head)
        if not caseDirection then --the head is moved
            caseDirection = {
                [1] = function(head); head.y = head.y - 1; end,
                [2] = function(head); head.x = head.x - 1; end,
                [3] = function(head); head.y = head.y + 1; end,
                [4] = function(head); head.x = head.x + 1; end,
            }
        end
        caseDirection[direction](snek.head)
        if not growth then --if the snake didn't move the tip of the tail is cut
            snek.body[#snek.body] = nil
        end
    end

    return ret
end

