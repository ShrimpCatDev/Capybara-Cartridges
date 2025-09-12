local dlg={}
local lg=love.graphics

function dlg.init()
    dlg.queue={}
    dlg.time=0
    dlg.time2=0
    dlg.show=false
    dlg.speedup=1
    dlg.pt=-1
end

function dlg.update(dt)  

    if #dlg.queue < 1 then
        dlg.show=false
        dlg.time=0
        dlg.time2=0
        dlg.pt=-1
    else
        dlg.pt=dlg.time

        dlg.time2=dlg.time2+((dlg.queue[1].spd*dlg.speedup)*dt)
        dlg.time=math.floor(dlg.time2)

        local q=dlg.queue[1]
        if dlg.pt<dlg.time and string.sub(q.txt,1,dlg.time)~=q.txt then
            --dlg.sound:stop()
            --dlg.sound:play()
        end
    end
    
end

function dlg.draw(x,y,w,h)
    lg.push()
        lg.translate(x,y)
        
        if dlg.show then
            lg.setColor(0,0,0)
            lg.rectangle("fill",1,1,w,h)
            lg.setColor(0,0,0)
            lg.rectangle("fill",0,0,w,h)
            lg.setColor(1,1,1)
            lg.rectangle("line",0,0,w,h)

            local q=dlg.queue[1]
            if q.img then
                lg.setColor(1,1,1)
                lg.draw(q.img,2,(h/2)+2,0,1,1,0,q.img:getWidth()/2)
                lg.printf(string.sub(q.txt,1,dlg.time),lg.getFont(),q.img:getWidth()+4,2,(w-4)-q.img:getWidth())
            else
                lg.setColor(1,1,1)
                lg.printf(string.sub(q.txt,1,dlg.time),lg.getFont(),2,2,w-4)
            end
            
        end
    lg.pop()
    lg.setColor(1,1,1)
end

function dlg.keypressed(k)
    if k=="space" and #dlg.queue>0 then
        local q=dlg.queue[1]
        if string.sub(q.txt,1,dlg.time)==q.txt then
            table.remove(dlg.queue,1)
            dlg.time=0
            dlg.time2=0
            dlg.pt=-1
            if dlg.fun then dlg.fun() end
        else
            dlg.speedup=2
        end
    end
end

function dlg.keyreleased(k)
    if k=="space" then
        dlg.speedup=1
    end
end

function dlg.addText(txt,spd,img,align,color,complete)
    local a=align or "right"
    table.insert(dlg.queue,{txt=txt,spd=spd,color=color or 2,img=img or nil,align=a,fun=complete or function() end})
    dlg.show=true
end

return dlg