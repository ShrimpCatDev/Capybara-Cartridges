local pg={}

function pg:enter()
    shove.createLayer("pg")
end

function pg:update()

end

function pg:draw()
    shove.beginDraw()
        shove.beginLayer("pg")

        shove.endLayer()
    shove.endDraw()
end

return pg