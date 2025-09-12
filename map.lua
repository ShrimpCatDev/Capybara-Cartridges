local worldMap={}

function worldMap:init()
    
end

function worldMap:enter()
    world=bump.newWorld(64)
    map=sti("assets/map/worldMap.lua",{"bump"})
    map:bump_init(world)

    select={x=8,y=96,w=8,h=8,vx=0,vy=0,spd=100}
    world:add(select,select.x,select.y,select.w,select.h)

    camera={x=0,y=0}

    points={}

    data=map.layers["levels"]
    for _,p in pairs(data.objects) do
        table.insert(data,{x=p.x,y=p.y,lvl=p.properties["level"],w=p.width,h=p.height})
    end

end

function worldMap:update(dt)
    map:update(dt)
    input:update()
    x,y=input:get('move')
    select.vx=x*select.spd*dt
    select.vy=y*select.spd*dt
    local ax,ay,col,len=world:move(select,select.x+select.vx,select.y+select.vy)
    select.x,select.y=ax,ay

    camera.x=(select.x+(select.w/2))-config.gameWidth/2
    camera.y=(select.y+(select.h/2))-config.gameHeight/2
    camera.x=clamp(camera.x,0,(map.width*map.tilewidth)-config.gameWidth)
    camera.y=clamp(camera.y,0,(map.height*map.tileheight)-config.gameHeight)

    data=map.layers["levels"]
    for _,p in pairs(data.objects) do
        --table.insert(data,{x=p.x,y=p.y,lvl=p.properties["level"],w=p.width,h=p.height})
        if collision(select.x,select.y,p.x,p.y,select.w,select.h,p.width,p.height) and input:pressed("confirm") then
            gs.switch(state.level)
        end
    end
end

function worldMap:draw()
    push:start()
        lg.push()
        local camX=math.floor(-camera.x)
        local camY=math.floor(-camera.y)
        lg.translate(camX,camY)
        map:draw(camX,camY)
        lg.rectangle("fill",math.floor(select.x),math.floor(select.y),8,8)
        lg.pop()
    push:finish()
    lg.print(x..", "..y)
end

return worldMap