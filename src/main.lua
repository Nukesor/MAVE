require("core/resources")
require("core/stackhelper")
require("core/helper")
require("states/MainState")
require("states/MenuState")
require("states/WinState")
require("states/GameOverState")
require("states/CreditsState")



function love.load()
    resources = Resources()
    resources:addImage("cutie1", 'data/gfx/cutie-0.png')
    resources:addImage("cutie0", 'data/gfx/cutie-1.png')
    resources:addImage("cutie2", 'data/gfx/cutie-2.png')
    resources:addImage("cutie3", 'data/gfx/cutie-3.png')
    resources:addImage("cutie4", 'data/gfx/cutie-4.png')
    resources:addImage("cutie5", 'data/gfx/cutie-5.png')
    resources:addImage("arena", 'data/gfx/arena.png')

    resources:addSound("bounce1", 'data/sfx/bounce_low_level.ogg')

    resources:addFont("font1", 'data/font/SwankyandMooMoo.ttf')

    resources:load()
    
    love.graphics.setMode(1000, 600, false, true, 0) -- Fensteroberfläche

    credits = CreditsState()
    main = MainState()
    menu = MenuState()
    win= WinState()
    gameover= GameOverState()
    stack = StackHelper()
    stack:push(menu)
end


function love.update(dt)
	stack:update(dt)
end

function love.draw()
	stack:draw()
end


function love.keypressed(key, u)
    stack:keypressed(key, u)
end