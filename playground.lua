local pg={}

local rd=6.283185

function pg:enter()
    shove.createLayer("pg")
end

function pg:update()

end

function pg:draw()
    shove.beginDraw()
        shove.beginLayer("pg")

            px,py=0,0

            setColor("#246ee5")
            lg.circle("fill",px,py,14+math.cos(love.timer.getTime()*3)*2)

            setColor("#91c4ff")
            local m=8
            for i=0,m-1 do
                lg.circle("fill",px-math.sin(love.timer.getTime()+i*(rd/m))*10,py-math.cos(love.timer.getTime()+i*(rd/m))*10,4)
            end

            setColor("#fff4ca")
            lg.circle("fill",px,py,8)

            setColor("#b8e4ff")
            local m=8
            for i=0,m-1 do
                lg.circle("fill",px-math.cos(love.timer.getTime()+i*(rd/m))*8,py-math.sin(love.timer.getTime()+i*(rd/m))*8,3)
            end
            
        shove.endLayer()
    shove.endDraw()
end

return pg