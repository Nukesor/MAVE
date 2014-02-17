require("lib/lua-lovetoys/lovetoys/engine")

require("helper/saves")
require("helper/tables")
require("helper/menu")
require("helper/math")

require("core/resources")
require("core/stackhelper")
require("core/gameplay")
require("core/util")
require("core/settings")
require("core/state")

require("states/levelState")
require("states/levels/levelOneState")
require("states/levels/levelTwoState")

require("states/menuState")
require("states/gameOverState")
require("states/creditsState")
require("states/pauseState")
require("states/selectState")
require("states/shopState")
require("states/promptState")
require("states/settingState")


function love.load()
    resources = Resources()

    -- Menus
    resources:addImage("logo", "data/gfx/menu/logo.png")
    resources:addImage("sold", "data/gfx/menu/sold.png")
    resources:addImage("button", "data/gfx/menu/button.png")
    resources:addImage("button_pressed", "data/gfx/menu/button_pressed.png")


    -- Cutie Graphics
    resources:addImage("cutie1", 'data/gfx/cuties/cutie-0.png')
    resources:addImage("cutie0", 'data/gfx/cuties/cutie-1.png')
    resources:addImage("cutie2", 'data/gfx/cuties/cutie-2.png')
    resources:addImage("cutie3", 'data/gfx/cuties/cutie-3.png')
    resources:addImage("cutie4", 'data/gfx/cuties/cutie-4.png')
    resources:addImage("cutie5", 'data/gfx/cuties/cutie-5.png')


    -- Particles
    resources:addImage("blood1", 'data/gfx/particles/blood1.png')
    resources:addImage("blood2", 'data/gfx/particles/blood2.png')
    resources:addImage("blood3", 'data/gfx/particles/blood3.png')
    resources:addImage("particle1", 'data/gfx/particles/particle1.png')

    -- Levelelements
    resources:addImage("background", 'data/gfx/menu/background.png')
    resources:addImage("level2", 'data/gfx/level/level2.png')
    resources:addImage("platform1", 'data/gfx/level/platform1.png')


    -- Weapongraphics
    resources:addImage("shot", 'data/gfx/weapons/shot.png')
    resources:addImage("grenade", 'data/gfx/weapons/grenade.png')
    resources:addImage("gun", "data/gfx/weapons/lmg.png")
    resources:addImage("mine", "data/gfx/weapons/mine.png")
    resources:addImage("rocket", "data/gfx/weapons/rocket.png")
    resources:addImage("rocketlauncher", "data/gfx/weapons/rocketlauncher.png")


    -- Fonts
    resources:addFont("seventeen", "data/font/Skranji-Regular.ttf", 17)
    resources:addFont("twenty", "data/font/Skranji-Regular.ttf", 20)
    resources:addFont("twentyfive", "data/font/Skranji-Regular.ttf", 25)
    resources:addFont("thirty", "data/font/Skranji-Regular.ttf", 30)
    resources:addFont("forty", "data/font/Skranji-Regular.ttf", 40)
    resources:addFont("fifty", "data/font/Skranji-Regular.ttf", 50)
    resources:addFont("sixty", "data/font/Skranji-Regular.ttf", 60)
    
    resources:load()

    set = Settings()
    Saves:loadSettings()
    gameplay = Gameplay()
    
    stack = StackHelper()
    
    stack:push(MenuState())
end


function love.update(dt)
    stack:update(dt)
end

function love.draw()
    stack:draw()
end 

function love.keypressed(key, isrepeat)
    stack:current():keypressed(key, isrepeat)
end

function love.mousereleased(x, y, button)
    stack:current():mousereleased(x, y, button)
end

function love.mousepressed(x, y, button)
    stack:current():mousepressed(x, y, button)
end

function love.quit()
    Saves:saveGame()
end
