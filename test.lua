
function main()
    initscr()
    curs_set(0)
    mvprintw(3,20,"lol")
    refresh()
    wait(50000000)
    endwin()
end

function wait(n)
    for i=1,n do
        local a="lol"
        a= a..a..a
    end
end
