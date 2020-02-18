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

function createSnek(y, x)
    local ret = {head = pos(y,x), body={}}

    ret.show = function(snek)
        set_color(head.color)
        mvprintw(offset + snek.head.y - 1, offset + snek.head.x - 1, head.char)
        for i=1,#snek.body do
            set_color(body.color)
            mvprintw(offset + snek.body[i].y - 1, offset + snek.body[i].x -1, body.char)
        end
    end

    --the direction is relataive to the head as defined in the begining of the fine, the size of the snek is increased by one 
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
    end

    --cut the last piece of the body of the snek
    ret.cut = function(snek)
        snek.body[#snek.body] = nil
    end

    --see if the snake is biting its tail or not
    ret.biting = function(snek)
        for i=1,#snek.body do
            if snek.head:compare(snek.body[i]) then
                return true
            end
        end
        return false
    end

    --see if the coordonate of  pos are on the snake
    ret.isSnek = function(snek, pos)  
        for i=1,#snek.body do
            if snek.body[i]:compare(pos) then
                return true
            end
        end
        return snek.head:compare(pos)
    end

    return ret
end

