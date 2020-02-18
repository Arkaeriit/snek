--[[
This file contains the help function and functions to get infos about installed maps
]]

function help()
    print("Sorry, mate. Nothing here")
    return 0
end

function invalidArgs()
    io.stderr:write("Error : invalid arguments.\n","To print help type `snek help`\n")
    return 1
end

--This function return a list of all the filenames of installed maps
function listMaps()
    local ret1 = ls("/usr/local/share/snek/maps")
    local ret2 = ls("/usr/share/snek/maps")
    for i=1,#ret1 do --We remove doubles, /usr/local got priority
        for k,v in pairs(ret2) do
            if ret1[i] == v then
                ret2[k] = nil
            end
        end
    end
    for i=1,#ret1 do --we complete names in ret1
        ret1[i] = "/usr/local/share/snek/maps/"..ret1[i]
    end
    for k,v in pairs(ret2) do
        ret2[k] = "/usr/local/share/snek/maps/"..v --we complete names in ret2
        ret1[#ret1+1] = ret2[k] --we append ret2 to ret1
    end
    if #ret1 > 0 then
        return ret1
    else
        return ret2
    end
end

--change a full filename into a limited one. ex : /path/to/file -> file
function justFileName(filename)
    local slash = 0 --position of the /
    for i=1,#filename do
        if filename:sub(i,i) == "/" then
            slash = i
        end
    end
    return filename:sub(slash+1,#filename)
end

--present the map named filename in a pretty way
function presentMap(filename)
    io.stdout:write("* ")
    io.stdout:write(justFileName(filename))
    io.stdout:write(" : ")
    local f = io.open(filename,"r")
    io.stdout:write(f:read())
    io.stdout:write('\n')
end

--present all the avalaible maps
function displayAvailableMaps()
    local list = listMaps()
    for i=1,#list do
        presentMap(list[i])
    end
    return 0
end

