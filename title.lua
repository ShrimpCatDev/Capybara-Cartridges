local title={}

function title:enter()
    shove.createLayer("titleFg")
end

function title:update(dt)
    input:update()

    if input:pressed("confirm") then
        gs.switch(state.select)
    end
end

function title:draw()
    shove.beginDraw()
        shove.beginLayer("titleFg")
            setColor("#fff4ca")
            lg.cPrint("Capybara Cartridges",config.gameWidth/2,20)
            lg.cPrint("Featuring a VERY",config.gameWidth/2,20+9)
            lg.cPrint("polished title screen",config.gameWidth/2,20+17)

            lg.cPrint("press A or Z",config.gameWidth/2,70)
        shove.endLayer()
    shove.endDraw()
end

return title