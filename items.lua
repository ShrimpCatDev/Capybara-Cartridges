local items={objs={}}
local toRemove={}

items.kinds={
    {img=lg.newImage("assets/items/leaf.png"),
    w=8,h=8,
    func=function()
        changeScore(50)
    end}
}

function items:init()
    self.objs={}
end

function items:update(dt)
    toRemove={}
    for k,i in ipairs(self.objs) do
        if collision(i.x,i.y,pl.x,pl.y,i.w,i.h,pl.w,pl.h) then
            table.insert(toRemove,k)
            i.func()
        end
    end
    for k,i in ipairs(toRemove) do
        table.remove(items.objs,i)
    end
end

function items:draw()
    for k,i in ipairs(self.objs) do
        lg.draw(i.img,i.x,i.y)
    end
end

function items:new(x,y,t)
    local k=self.kinds[t]
    table.insert(self.objs,{x=x,y=y,img=k.img,w=k.w,h=k.h,func=k.func})
end

return items