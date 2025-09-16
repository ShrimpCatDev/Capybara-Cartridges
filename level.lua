local level={}

function changeScore(s)
    score=score+s
    bar.show=true
    bar.timer=2
end

function showBar(dur)
    bar.show=true
    bar.timer=dur or 2
end

function filter(item, other)
    if other.pass then
        return "cross"
    else
        return "slide"
    end
    --return "slide"
end

function level:init()

    --add the player code
    pl=require("player")

    --init particles
    part=require("particles")
    part.assets={
        enemy1=lg.newImage("assets/enemy/dead1.png"),
        box=lg.newImage("assets/items/box.png"),
        leaf=lg.newImage("assets/items/leaf.png")
    }

    --add shaders and send the right data to them
    shader=require("assets/shader")
    shader.wave:send("amp",0.01)
    shader.wave:send("freq",20)
    shader.wave:send("spd",4)

    shader.water:send("amp",0.01)
    shader.water:send("freq",20)
    shader.water:send("spd",4)

    --shove.addGlobalEffect(shader.crt)

    
end

function level:enter(prev,lvl)

    input:update()

    pTime=0
    frozen=false

    require("lib.lovebird").update()
    
    bar={x=0,y=-9,show=false,timer=0}

    timer.clear()
    part.clear()

    gravity=240

    world=bump.newWorld(16)

    if lvl then
        map=sti("assets/map/"..lvl..".lua",{"bump"})
    else
        map=sti("assets/map/dev.lua",{"bump"})
    end
    map:bump_init(world)

    items=require("items")
    items:init()

    enemy=require("enemies/enemy1")
    
    enemy:init(map)

    camera={x=0,y=0}

    pl:init(0,0)

    for x=0,map.width-1 do
        for y=0,map.height-1 do
            local data=map:getTileProperties("enemy",x+1,y+1)
            if data.player then
                pl.x,pl.y=x*8,y*8
                map:setLayerTile("enemy",x+1,y+1,0)
            end
            
            
        end
    end

    bgs.current=bgs[1]
    bgs.current.init()

    require("lib.lovebird").update()

    shove.createLayer("bg")
    shove.createLayer("game")
    shove.createLayer("ui")

    water={y=128}
    time=999999

    shove.clearEffects("game")
    shove.clearEffects("bg")

    shove.addEffect("game",shader.water)
    shove.addEffect("bg",shader.wave)
    shove.addEffect("bg",shader.water)

    mul=1
    
end

function level:update(dt2)

    dt=dt2*mul

    timer.update(dt)
    require("lib.lovebird").update()
    input:update()

    if not frozen then

        pTime=pTime+dt
        time=time-dt

        --water.y=water.y-dt*5

        shader.water:send("waterY",water.y)

        shader.wave:send("time",pTime)
        shader.water:send("time",pTime)

        bar.timer=bar.timer-dt
        if bar.timer<=0 then
            bar.show=false
        end

        if bar.show then
            bar.y=lerpDt(bar.y,0,25,dt)
        else
            bar.y=lerpDt(bar.y,-9,25,dt)
        end

        pl:update(dt)
        map:update(dt)
        items:update(dt)
        enemy:update(dt)

        part.update(dt)
    

        camera.x=(pl.x+(pl.w/2))-config.gameWidth/2
        camera.y=(pl.y+(pl.h/2))-config.gameHeight/2
        camera.x=clamp(camera.x,0,(map.width*map.tilewidth)-config.gameWidth)
        camera.y=clamp(camera.y,0,(map.height*map.tileheight)-config.gameHeight)

        if input:pressed("stats") then
            showBar()
        end

        bgs.current.update(dt)
    end

end

function level:draw()

    if bgs.current.drawCanvas then bgs.current.drawCanvas() end
    --push:start()
    shove.beginDraw()
        --push:setShader(shader.wave)
        shove.beginLayer("bg")
            bgs.current.draw()
        shove.endLayer()

        shove.beginLayer("game")
            lg.push()
            local camX=math.floor(-camera.x)
            local camY=math.floor(-camera.y)
            lg.translate(camX,camY)
            map:draw(camX,camY)
            --boxes:draw()
            items:draw()
            enemy:draw()
            pl:draw()
            part.draw()
            lg.pop()
        shove.endLayer()
        
        shove.beginLayer("ui")
        lg.push()
        lg.translate(bar.x,bar.y)
            setColor("#131a4e")
            lg.rectangle("fill",0,0,config.gameWidth,font:getHeight()+1)
            setColor("#fff4ca")
            lg.cPrint(score,config.gameWidth/2,1)
            setColor("#246ee5")
            local hpW=2
            local hpH=7
            for i=0,pl.hp-1 do
                lg.rectangle("fill",i*(hpW+1)+1,1,hpW,hpH)
            end
        lg.pop()
        lg.setColor(1,1,1,1)
    lg.print(tostring(mul),1,1)
        shove.endLayer()
        
    --push:finish()
    
    shove.endDraw()
    
end

function level:keypressed(k)
    if k=="p" then
        if frozen then
            frozen=false
        else
            frozen=true
        end
    end
    if k=="w" then
        mul=mul+.5
    end
    if k=="s" then
        mul=mul-.5
    end
end

return level