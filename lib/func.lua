function outlineText(text,x,y,colorOutline,colorFill)
    lg.setColor(colorOutline[1],colorOutline[2],colorOutline[3])
    lg.print(text,x+1,y)
    lg.print(text,x-1,y)
    lg.print(text,x,y+1)
    lg.print(text,x,y-1)
    lg.setColor(colorFill[1],colorFill[2],colorFill[3])
    lg.print(text,x,y)
    lg.setColor(1,1,1)
end

function centerOutlineText(text,x,y)
    local w=font:getWidth(text)
    outlineText(text,x-(w/2)-camera.x,y-(font:getHeight()/2)-camera.y,1,2)
end

function lg.cPrint(text,x,y)
    local w=font:getWidth(text)
    --y-(font:getHeight()/2)
    lg.print(text,x-(w/2),y)
end

function setColor(hex)
    lg.setColor(color(hex))
end

function resetColor()
    lg.setColor(1,1,1,1)
end

function clamp(x, min, max)
    return math.max(min, math.min(x, max))
end

function lerpDt(a, b, t,dt)
    return a + (b - a) * (t*dt)
end

function lerp(a, b, t,dt)
    return a + (b - a) * t
end

function collision(x1,y1,x2,y2,w1,h1,w2,h2)
    return x1<x2+w2 and x2<x1+w1 and y1<y2+h2 and y2<y1+h1 
end

rr=love.graphics.rectangle

function rect(f,x,y,w,h)
    if f=="fill" then
        rr(f,x,y,w,h)
    else
        rr(f,x+.5,y+.5,w,h)
    end
end

function pointCol(pX, pY, bx, by, bw, bh)
    return pX >= bx and pX < bx + bw and pY >= by and pY < by + bh
end

lg.rectangle=rect