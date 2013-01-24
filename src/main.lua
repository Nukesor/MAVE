require("core/resources")
require("core/stackhelper")
require("core/helper")
require("objects/cutie")
require("states/main")
require("states/menu")


GameState = class(StackHelper)

function love.load()

    resources = class(Resources)
    

    resources:addImmage("cutie0", 'data/gfx/cutie-0.png')
    resources:addImmage("cutie1", 'data/gfx/cutie-1.png')
    resources:addImmage("cutie2", 'data/gfx/cutie-2.png')
    resources:addImmage("cutie3", 'data/gfx/cutie-3.png')
    resources:addImmage("cutie4", 'data/gfx/cutie-4.png')
    resources:addImmage("cutie5", 'data/gfx/cutie-5.png')
    resources:addImmage("arena", 'data/gfx/arena.png')

    love.graphics.setMode(1000, 600, false, true, 0) -- Fensteroberfläche

    resources:load()

    main = class(MainState)
    GameState:setup()

    if GameState:current() ~= nil  then GameState:push(main) end

end


function love.update(dt)
	StackHelper:update(dt)
end

function love.draw()

	GameState:draw()

end
