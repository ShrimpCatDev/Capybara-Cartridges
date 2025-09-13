local bg={}

function bg.init()
    bg.brick=lg.newImage("assets/bg/brick.png")
    bg.brick2=lg.newImage("assets/bg/brick2.png")
    bg.brick:setWrap("repeat","repeat")
    bg.quad=lg.newQuad(0,0,map.width*16,map.height*8,bg.brick:getWidth(),bg.brick:getHeight())

    bg.canvas=lg.newCanvas(56,128)

    bg.lerpPos=0
    bg.cam=0

    bg.img=lg.newImage("assets/bg/bg.png")
    
end

function bg.update(dt)
    bg.lerpPos=lerpDt(bg.lerpPos,(camera.x*0.08),4,dt)
    bg.cam=lerpDt(bg.cam,camera.x*0.3,8,dt)
end

function bg.drawCanvas()
    lg.setCanvas(bg.canvas)
    --lg.rectangle("fill",0,0,500,500)
        lg.draw(bg.brick,bg.quad,bg.lerpPos-((map.width*16)/2),0,0,1,1)
        lg.setColor(0.1,0,0.2,0.4)
        lg.rectangle("fill",0,0,8,128)
        lg.rectangle("fill",56-8,0,8,128)

        lg.setColor(0.05,0,0.3,0.4)
        lg.rectangle("fill",0,0,4,128)
        lg.rectangle("fill",56-4,0,4,128)

        lg.setColor(0,0,0,1)
        lg.rectangle("fill",0,0,1,128)
        lg.rectangle("fill",55,0,1,128)
    lg.setCanvas()
    resetColor()
end

local colors={
    "#91c4ff",
    "#b8e4ff",
    "#fff4ca"
}

function bg.draw()

    setColor("#246ee5")
    lg.rectangle("fill",0,0,config.gameWidth,config.gameHeight)
    resetColor()

    for x=-1,20 do
        setColor(colors[1])
        lg.draw(bg.img,x*bg.img:getWidth()+-bg.cam*0.4,32)
    end

    

    resetColor()

    lg.draw(bg.canvas,config.gameWidth/2,0,0,1,1,bg.canvas:getWidth()/2,0)

    for x=-1,20 do
        setColor(colors[3])
        lg.draw(bg.img,x*bg.img:getWidth()+bg.cam*0.6+40,64)
    end
end

return bg