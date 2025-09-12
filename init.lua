lg=love.graphics

local lgp=love.graphics.points

function lg.rectLine(x,y,w,h)
    lg.rectangle("line",x+0.5,y+0.5,w-0.5,h-0.5)
end

function lg.points(x,y)
    lgp(math.floor(x)+0.5,math.floor(y)+0.5)
end

function love.graphics.points(x,y)
    lgp(math.floor(x)+0.5,math.floor(y)+0.5)
end

config=require 'config'

lg.setDefaultFilter(config.filterMin,config.filterMax)
lg.setLineStyle("rough")

--push=require 'lib/push'
shove=require('lib/shove')
--push:setupScreen(config.gameWidth,config.gameHeight,config.windowWidth,config.windowHeight,{resizable=config.resizable,fullscreen=config.fullscreen,pixelperfect=config.pixelperfect})
shove.setResolution(config.gameWidth,config.gameHeight,{fitMethod="pixel",renderMode="layer"})
shove.setWindowMode(config.windowWidth,config.windowHeight,{resizable=true})


baton=require 'lib/baton'
input=baton.new(config.input)

anim8=require('lib/anim8')

color=require'lib/hex2color'

sti=require"lib/sti"

require'lib/func'