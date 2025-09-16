require 'init'

function love.load()
    pTime=0
    font=lg.newImageFont("assets/font.png","ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 1234567890:.!?",1)
    lg.setFont(font)

    gs=require'lib.hump.gamestate'
    Camera=require 'lib.hump.camera'
    timer=require 'lib.hump.timer'
    
    gs.registerEvents()

    bump=require 'lib/bump'

    state={
        level=require 'level',
        boot=require 'intro',
        map=require 'map',
        select=require 'select'
    }

    bgs={
        require("bg/clouds"),
        require("bg/tower")
    }

    score=0
    lives=3

    gs.switch(state.select)
end

function love.update(dt)

end

function love.draw()

end

function love.resize(w,h)
    --push:resize(w,h)
end

function love.keypressed(k)
    if k=="f11" then
        --push:switchFullscreen(w, h)
    end
    if k=="r" then
        gs.switch(state.level)
    end
end