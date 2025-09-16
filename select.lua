local select={}

function select:enter()
    shader=require("assets/shader")
    input:update()
    self.sel={x=0,y=0}
    self.spacing={x=14,y=10}
    self.offset={x=6,y=6}
    self.max=13
    self.levels=require("levelData")

    shove.createLayer("selectBg")

    shove.createLayer("select")
    

    --shove.clearEffects("selectBg")
    --shove.addEffect("selectBg",shader.plasma)

end

function select:update()

    shader.plasma:send("time",love.timer.getTime())

    input:update()

    if input:pressed("up") then
        self.sel.y=self.sel.y-1
    end
    if input:pressed("down") then
        self.sel.y=self.sel.y+1
    end
    if input:pressed("left") then
        self.sel.x=self.sel.x-1
    end
    if input:pressed("right") then
        self.sel.x=self.sel.x+1
    end

    if input:pressed("confirm") then
        gs.switch(state.level,self.levels[(self.sel.x+1)+(self.sel.y*self.max)].id)
    end

end

function select:draw()
    shove.beginDraw()
        shove.beginLayer("selectBg")
            --setColor("#b8e4ff")
            --lg.rectangle("fill",0,0,192,128)
            --resetColor()
        shove.endLayer()

        shove.beginLayer("select")
        resetColor()
            for i=0,#self.levels-1 do

                local x=math.floor((i%self.max)*self.spacing.x+self.offset.x)
                local y=math.floor(math.floor(i/self.max)*self.spacing.y+self.offset.y+math.cos(love.timer.getTime()*6+(i%self.max)*0.7)*1.5)

                if self.sel.x==i%self.max and self.sel.y==math.floor(i/self.max) then
                    if i%2==0 then
                        setColor("#f5a87d")
                    else
                        setColor("#91c4ff")
                    end
                else
                    if i%2==0 then
                        setColor("#eb5d3d")
                    else
                        setColor("#246ee5")
                    end
                end

                lg.rectangle("fill",x-1,y-1,self.spacing.x-1,self.spacing.y-1)

                setColor("#fff4ca")
                lg.print(tostring(i+1),x,y)
            end

            --lg.print(tostring((self.sel.x+1)+(self.sel.y*self.max)),0,64)

            lg.cPrint(self.levels[(self.sel.x+1)+(self.sel.y*self.max)].name,config.gameWidth/2,config.gameHeight-9)
            
        shove.endLayer()
    shove.endDraw()
end

function select:leave()
    shove.removeLayer("select")
end

return select