return {

    --screen utils
    gameWidth=24*8,
    gameHeight=128,
    windowWidth=24*8*5,
    windowHeight=128*5,
    fullscreen=false,
    resizable=true,
    pixelperfect=true,

    --texture
    filterMin="nearest",
    filterMax="nearest",

    --input
    input={
        controls={
            right={"key:right","axis:leftx+"},
            left={"key:left","axis:leftx-"},
            down={"key:down","axis:lefty+"},
            up={"key:up","axis:lefty-"},
            jump={"key:z","button:a"},
            item={"key:x","button:b"},
            confirm={"key:z","button:a"},
            stats={"key:c","button:y"},
        },
        pairs={
            move={"left","right","up","down"}
        },
        joystick = love.joystick.getJoysticks()[1]
    }

}

