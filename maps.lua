--[[
This file contain what is needed to generate the map or read it from
a text file and to display it.
]]

--[[the map is represeted as a 2 dimention array
The possible elements are :
    void : nothing on the case
    wall : a wall on the case
Each element got an ID, a color palette and a representing character
]]

--definitions
void = {id = 0, color = 1, char = " "}
wall = {id = 1, color = 2, char = " "}

--generate the most boring map you can think of
function rectangleMap(x, y)
    local ret = {}
    for i=1,x do
        ret[i] = {}
        for j=1,y do
            if i==1 or j==1 or i==x or j==y then
                ret[i][j] = wall
            else
                ret[i][j] = void
            end
        end
    end
    return ret
end

--draw a map a tad to the top left of the terminal
function drawMap(map)
    move(2,2) --we move a bit for padding
    for i=1,#map do
        move(i+1,2)
        for j=1,#map[i] do
            local case = map[i][j]
            set_color(case.color)
            printw(case.char)
        end
    end
end




