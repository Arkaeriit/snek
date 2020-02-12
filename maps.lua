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
void = {id = 0, color = 1, char = "."} --the dot is for debugging
wall = {id = 1, color = 2, char = " "}
head = {id = 2, color = 1, char = "@"}
body = {id = 3, color = 1, char = "+"}

--generate the most boring map you can think of
function rectangleMap(x, y)
    local ret = map()
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
    for i=1,#map do
        move(i+offset-1, offset)
        for j=1,#map[i] do
            local case = map[i][j]
            set_color(case.color)
            printw(case.char)
        end
    end
end

--a basic map class
function map()
    local ret = {}
    ret.show = drawMap
    return ret
end


