local enemy={
    img=lg.newImage("assets/enemy/enemy1.png"),
    enemies={},
    w=10,h=10
}

enemy.anim={}
local g=anim8.newGrid(enemy.w,enemy.h,enemy.img:getWidth(),enemy.img:getHeight())
enemy.anim.run=anim8.newAnimation(g('1-7',1),0.05)

local toRemove={}


function enemy:new(x,y,dir)
    print("enemy added at x: "..x..", y: "..y..", direction: "..dir)
    table.insert(self.enemies,{jump=false,x=x,y=y-1,dir=dir,vx=0,vy=0,anim=anim8.newAnimation(g('1-7',1),0.05),pass=true,w=enemy.w,h=enemy.h})
    world:add(self.enemies[#self.enemies],self.enemies[#self.enemies].x,self.enemies[#self.enemies].y,self.enemies[#self.enemies].w,self.enemies[#self.enemies].h)
end

function enemy:init(map)
    self.enemies={}
    for x=0,map.width-1 do
        for y=0,map.height-1 do
            local data=map:getTileProperties("enemy",x+1,y+1)
            if data.enemy=="enemy1" then
                enemy:new(x*8-2,y*8-1,data.dir)
                lg.print("data dir: "..data.dir)
                map:setLayerTile("enemy",x+1,y+1,0)
            end
            
            
        end
    end
end

function enemy:update(dt)
    toRemove={}
    for k,e in pairs(self.enemies) do
        e.anim:update(dt)
        e.vy=e.vy+gravity*2*dt
        e.vx=50*e.dir*dt

        local ax,ay,col,len=world:move(e,e.x+e.vx,e.y+e.vy*dt,filter)
        e.x,e.y=ax,ay

        for i=1,len do
            if col[i].other.properties then
                if col[i].other.properties.platform and col[i].normal.y==-1 then
                    e.vy=0
                    e.jump=true
                end
    
                if col[i].other.properties.platform and col[i].normal.y==1 then
                    e.vy=0
                    e.jump=false
                end

                if col[i].other.properties.platform and col[i].normal.x==-1 and col[i].normal.y==0 then
                    e.dir=-1
                    print("i bounced on something to the right of me")
                end

                if col[i].other.properties.platform and col[i].normal.x==1 and col[i].normal.y==0 then
                    e.dir=1
                    print("i bounced on something to the left of me")
                end

            elseif col[i].other.pass then
                if col[i].other==pl then
                    if pl.y+(pl.h/2)<=e.y and pl.vy>0 then
                        if not pl.cantMove then
                            world:remove(e)
                            table.insert(toRemove,k)
                            pl.vy=-80
                            part.new(e.x,e.y,20,-80,0,350,3,
                            function(x,y,l)
                                lg.draw(part.assets.enemy1,x,y)
                            end)
                            changeScore(100)
                        end
                    else
                        pl:damage(4)
                    end
                end
            end
        end
    end

    for k,v in ipairs(toRemove) do
        table.remove(self.enemies,v)
    end
end

function enemy:draw()
    for k,e in ipairs(self.enemies) do
        if e.dir==1 then
            e.anim:draw(self.img,e.x,e.y,0,1,1,0,0)
        else
            e.anim:draw(self.img,e.x,e.y,0,-1,1,e.w,0)
        end
    end
end

return enemy