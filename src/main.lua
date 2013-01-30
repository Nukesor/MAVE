require("core/resources")
require("core/stackhelper")
require("core/helper")
require("states/mainState")
require("states/menuState")



function love.load()
    resources = Resources()
    resources:addImage("cutie0", 'data/gfx/cutie-0.png')
    resources:addImage("cutie1", 'data/gfx/cutie-1.png')
    resources:addImage("cutie2", 'data/gfx/cutie-2.png')
    resources:addImage("cutie3", 'data/gfx/cutie-3.png')
    resources:addImage("cutie4", 'data/gfx/cutie-4.png')
    resources:addImage("cutie5", 'data/gfx/cutie-5.png')
    resources:addImage("arena", 'data/gfx/arena.png')
    resources:addMusic("bounce1", 'data/sfx/bounce_low_level.ogg')
    resources:load()
    
    love.graphics.setMode(1000, 600, false, true, 0) -- Fensteroberfläche

    main = MainState()
    states = StackHelper()
    states:push(main)
end


function love.update(dt)
	states:update(dt)
    love.timer.sleep(0.01)
end

function love.draw()
	states:draw()
end
