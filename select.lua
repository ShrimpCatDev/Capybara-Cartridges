local select={}

function select:enter()
    self.sel={x=0,y=0}
    self.spacing={x=14,y=10}
    self.offset={x=6,y=2}
    self.max=13
    self.levels={}--require("levelData")
    for i=1,52 do
        table.insert(self.levels,{})
    end
end

function select:update()
    shove.createLayer("select")
end

function select:draw()
    shove.beginDraw()
        shove.beginLayer("select")
            for i=0,#self.levels-1 do
                lg.print(tostring(i+1),(i%self.max)*self.spacing.x+self.offset.x,math.floor(i/self.max)*self.spacing.y+self.offset.y)
            end
        shove.endLayer()
    shove.endDraw()
end

function select:leave()
    shove.removeLayer("select")
end

return select