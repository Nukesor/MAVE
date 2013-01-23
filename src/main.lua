require("core/ressources")
require("core/gamestate")
require("objects/world")
require("objects/cutie")
require("states/main")
require("states/menu")


Gamestate = {}


function love.load()

    ressources:addImmage("cutie0", 'data/gfx/cutie-0.png')
    ressources:addImmage("cutie1", 'data/gfx/cutie-1.png')
    ressources:addImmage("cutie2", 'data/gfx/cutie-2.png')
    ressources:addImmage("cutie3", 'data/gfx/cutie-3.png')
    ressources:addImmage("cutie4", 'data/gfx/cutie-4.png')
    ressources:addImmage("cutie5", 'data/gfx/cutie-5.png')
    ressources:addImmage("arena", 'data/gfx/arena.png')

    love.graphics.setMode(1000, 600, false, true, 0) -- Fensteroberfläche

    ressources:load()

end

