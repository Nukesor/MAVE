require("core/class")
require("core/resources")
require("core/stackhelper")
require("core/gameplay")
require("core/util")

require("core/state")
require("states/MainState")
require("states/MenuState")
require("states/WinState")
require("states/GameOverState")
require("states/CreditsState")
require("states/PauseState")
require("states/SelectState")
require("states/ShopState")


function love.load()
    resources = Resources()
    resources:addImage("cutie1", 'data/gfx/cutie-0.png')
    resources:addImage("cutie0", 'data/gfx/cutie-1.png')
    resources:addImage("cutie2", 'data/gfx/cutie-2.png')
    resources:addImage("cutie3", 'data/gfx/cutie-3.png')
    resources:addImage("cutie4", 'data/gfx/cutie-4.png')
    resources:addImage("cutie5", 'data/gfx/cutie-5.png')
    resources:addImage("blood1", 'data/gfx/blood1.png')
    resources:addImage("arena", 'data/gfx/arena.png')
    resources:addImage("level1", 'data/gfx/level1.png')
    resources:addImage("shot", 'data/gfx/shot.png')
    resources:addImage("grenade", 'data/gfx/grenade.png')

    resources:addSound("bounce1", 'data/sfx/bounce_low_level.ogg')

    resources:addFont("seventeen", "data/font/SwankyandMooMoo.ttf", 17)
    resources:addFont("twenty", "data/font/SwankyandMooMoo.ttf", 20)
    resources:addFont("twentyfive", "data/font/SwankyandMooMoo.ttf", 25)
    resources:addFont("thirty", "data/font/SwankyandMooMoo.ttf", 30)
    resources:addFont("forty", "data/font/SwankyandMooMoo.ttf", 40)
    resources:addFont("fifty", "data/font/SwankyandMooMoo.ttf", 60)
    
    resources:addFont("default", "data/font/SwankyandMooMoo.ttf", 20)
    resources:addFont("big", "data/font/SwankyandMooMoo.ttf", 60)

    resources:load()
    
    love.graphics.setMode(1000, 600, false, true, 0) -- Fensteroberfläche

    credits = CreditsState()
    main = MainState()
    menu = MenuState()
    win = WinState()
    gameover = GameOverState()
    pause = PauseState()
    selectstate = SelectState()
    stack = StackHelper()
    shop = ShopState()
    gameplay = Gameplay()

    stack:push(menu)
end


function love.update(dt)
	stack:update(dt)
end

function love.draw()
	stack:draw()
end 

function love.keypressed(key, u)
    stack:current():keypressed(key, u)
end

function love.keyreleased(key, u)
    stack:current():keyreleased(key, u)
end

function love.mousepressed(x, y, button)
    stack:current():mousepressed(x, y, button)
end
