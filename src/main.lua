require("lib/class")
require("lib/resources")
require("lib/stackhelper")
require("lib/gameplay")
require("lib/util")
require("lib/settings")
require("lib/state")

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
    resources:addImage("cutie1", 'data/gfx/cutie-0.png')
    resources:addImage("cutie0", 'data/gfx/cutie-1.png')
    resources:addImage("cutie2", 'data/gfx/cutie-2.png')
    resources:addImage("cutie3", 'data/gfx/cutie-3.png')
    resources:addImage("cutie4", 'data/gfx/cutie-4.png')
    resources:addImage("cutie5", 'data/gfx/cutie-5.png')

    resources:addImage("blood1", 'data/gfx/blood1.png')
    resources:addImage("level2", 'data/gfx/arena.png')
    resources:addImage("level1", 'data/gfx/level1.png')
    resources:addImage("background", 'data/gfx/menu/background.png')
    resources:addImage("logo", "data/gfx/menu/logo.png")

    resources:addImage("shot", 'data/gfx/shot.png')
    resources:addImage("grenade", 'data/gfx/weapons/grenade.png')
    resources:addImage("gun", "data/gfx/weapons/lmg.png")
    resources:addImage("mine", "data/gfx/weapons/mine.png")

    resources:addSound("bounce1", 'data/sfx/bounce_low_level.ogg')

    resources:addFont("seventeen", "data/font/SwankyandMooMoo.ttf", 17)
    resources:addFont("twenty", "data/font/SwankyandMooMoo.ttf", 20)
    resources:addFont("twentyfive", "data/font/SwankyandMooMoo.ttf", 25)
    resources:addFont("thirty", "data/font/SwankyandMooMoo.ttf", 30)
    resources:addFont("forty", "data/font/SwankyandMooMoo.ttf", 40)
    resources:addFont("fifty", "data/font/SwankyandMooMoo.ttf", 50)
    resources:addFont("sixty", "data/font/SwankyandMooMoo.ttf", 60)
    
    resources:load()

    set = Settings()
    loadSettings()
    gameplay = Gameplay()
    
    stack = StackHelper()
    menu = MenuState()
    credits = CreditsState()
    setting = SettingState()
    selectstate = SelectState()
    shop = ShopState()
    prompt = PromptState()
    pause = PauseState()
    gameover = GameOverState()

    levelOne = LevelOneState()
    levelTwo = LevelTwoState()

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
