local buttons={btns={}}
function pointCol(px, py, bx, by, bw, bh)
    return px >= bx and px < bx + bw and py >= by and py < by + bh
end
function buttons.reset()
    buttons.btns={}
end
function buttons.new(x,y,w,h,drawFunc,func)
    table.insert(buttons.btns,{x=x,y=y,w=w,h=h,img=drawFunc,func=func})
end
function buttons.pressed(mx,my,btn)
    for i, b in pairs(buttons.btns) do
        if pointCol(mx,my, b.x, b.y, b.w, b.h) and btn==1 then
            b.func()
        end
    end
end
function buttons.draw(mx,my)
    for i, b in pairs(buttons.btns) do
        b.img(pointCol(mx,my, b.x, b.y, b.w, b.h),(love.mouse.isDown(1) and pointCol(mx,my, b.x, b.y, b.w, b.h)),b.x,b.y,b.w,b.h)
    end
end
return buttons