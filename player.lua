local pl={}
pl.img=lg.newImage("assets/player/run.png")

local g=anim8.newGrid(10,12,pl.img:getWidth(),pl.img:getHeight())
pl.anim={}

pl.anim.run=anim8.newAnimation(g("1-7",1),0.04)
pl.anim.idle=anim8.newAnimation(g("1-8",2),0.09)
pl.anim.jump=anim8.newAnimation(g("1-1",3),1)
pl.anim.fall=anim8.newAnimation(g("1-4",4),0.08)

pl.w=10
pl.h=10
pl.runSpd=90

pl.damageImg=lg.newImage("assets/player/damage.png")

function pl:damage(d)
    if not self.invincible then
        self.cantMove=true
        self.cooldown=0.5
        self.vy=-50
        if self.dir==1 then
            self.vx=-30
        else
            self.vx=30
        end
        self.invincible=true
        self.invisTimer=2.5
        self.hp=self.hp-d
        showBar()
    end
end

function pl:init(x,y)
    self.pass=true
    self.x= x or 0
    self.y= y or 0
    self.dir=1
    self.vx=0
    self.vy=0
    self.maxVx=90
    self.jump=false
    self.anim.current=self.anim.run

    self.invincible=false
    self.invisTimer=0
    self.cantMove=false
    self.cooldown=0

    self.hp=12

    world:add(self,self.x,self.y,self.w,self.h)
    --map:setLayerTile("tiles",9,38,0)
end

local bool=false

function pl:update(dt)

    self.invisTimer=self.invisTimer-dt

    if self.invisTimer<=0 then
        self.invincible=false
    end

    self.cooldown=self.cooldown-dt

    if self.cooldown<=0 then
        self.cantMove=false
    end

    self.anim.current:update(dt)

    self.vy=self.vy+(gravity*dt)
    self.jump=false

    self.anim.current=self.anim.idle

    if not self.cantMove then
        self.vx=0

        if input:down("right") then
            self.vx=self.runSpd
            self.dir=1
            self.anim.current=self.anim.run
        end
        if input:down("left") then
            self.vx=-self.runSpd
            self.dir=0
            self.anim.current=self.anim.run
        end
    end

    local ax,ay,col,len=world:move(self,self.x+(self.vx*dt),self.y+(self.vy*dt),filter)
    self.x,self.y=ax,ay
    for i=1,len do
        if col[i].other.properties then
            if col[i].other.properties.platform and col[i].normal.y==-1 then
                self.vy=0
                self.jump=true
            end

            if col[i].other.properties.box and col[i].normal.y==1 and not col[i].other.noHit then
                --col[i].other.properties.collidable=false
                --world:remove(col[i].other)
                local t=col[i].other
                
                map:setLayerTile("tiles",math.floor(t.x/8)+1,math.floor(t.y/8)+1,36)
                items:new(t.x,t.y-8,1)
                col[i].other.noHit=true

                part.new(col[i].other.x,col[i].other.y,0,-60,0,350,0.5,
                    function(x,y,l)
                        lg.draw(part.assets.box,x,y,0,1,math.abs(l*4))
                    end)
            end

            if col[i].other.properties.platform and col[i].normal.y==1 then
                self.vy=0
                self.jump=false
            end
            
        end
    end


    if self.jump then
        if input:down("right") or input:down("left") then
            self.anim.current=self.anim.run
        else
            self.anim.current=self.anim.idle
        end
    else
        if self.vy<=0 then
            self.anim.current=self.anim.jump
        else
            self.anim.current=self.anim.fall
        end
    end

    if input:pressed("jump") and self.jump then
        self.vy=-130
        self.jump=false
    end
    
    self.x=clamp(self.x,0,(map.width*map.tilewidth)-self.w)

end

function pl:draw()

    lg.setColor(1,1,1,1)

    if self.invincible and math.floor(self.invisTimer*16)%2==0 then
        lg.setColor(1,1,1,0.4)
    end

    if self.cantMove then
        if self.dir==1 then
            lg.draw(self.damageImg,math.floor(self.x),math.floor(self.y-(12-self.h)))
        else
            lg.draw(self.damageImg,math.floor(self.x),math.floor(self.y-(12-self.h)),0,-1,1,10)
        end
    else
        if self.dir==1 then
            self.anim.current:draw(self.img,math.floor(self.x),math.floor(self.y-(12-self.h)))
        else
            self.anim.current:draw(self.img,math.floor(self.x),math.floor(self.y-(12-self.h)),0,-1,1,10)
        end
    end
    --lg.rectLine(pl.x,pl.y,pl.w,pl.h)
    --lg.print(tostring(bool),camera.x,camera.y)
end

return pl