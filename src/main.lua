require("core/resources")
require("core/stackhelper")
require("core/helper")
require("objects/cutie")
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

    love.graphics.setMode(1000, 600, false, true, 0) -- Fensteroberfläche

    resources:load()

    main = MainState()

    states = StackHelper()
    if states:current() ~= nil  then states:push(main) end

end


function love.update(dt)
	states:update(dt)
end

function love.draw()
	main:draw()
end
