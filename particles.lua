local part={ps={}}

function part.new(x,y,vx,vy,ax,ay,lt,df)
    table.insert(part.ps,{x=x,y=y,vx=vx,vy=vy,ax=ax,ay=ay,df=df,lt=lt})
end

function part.update(dt)
    local dels={}
    for k,p in ipairs(part.ps) do
        p.vx=p.vx+(p.ax*dt)
        p.vy=p.vy+(p.ay*dt)
        p.x=p.x+(p.vx*dt)
        p.y=p.y+(p.vy*dt)
        p.lt=p.lt-dt
        if p.lt<0 then
            table.insert(dels,k)
        end
    end
    for k,i in ipairs(dels) do
        table.remove(part.ps,i)
    end
end

function part.draw()
    for k,p in ipairs(part.ps) do
        p.df(p.x,p.y,p.lt)
    end
end

function part.clear()
    part.ps={}
end

return part