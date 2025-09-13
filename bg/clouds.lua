local bg={}

bg.img=lg.newImage("assets/bg/bg.png")


local colors={
    "#91c4ff",
    "#b8e4ff",
    "#fff4ca"
}

local flip={-1,1,-1}


function bg.init()

end

function bg.update(dt)

end

function bg.draw()
    setColor("#246ee5")
    lg.rectangle("fill",0,0,config.gameWidth,config.gameHeight)
    resetColor()

    for y=0,2 do
        for x=-1,20 do
            setColor(colors[y+1])
            lg.draw(bg.img,math.floor((x*config.gameWidth)+(-camera.x*((y+1)*0.1))+(y*29)),(32+y*10)+(math.cos((love.timer.getTime()+(y*0.5))*4)),0,flip[y+1],1)
        end
    end
    resetColor()

    
end

return bg