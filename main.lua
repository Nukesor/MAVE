require("core/ressources")
require("core/gamestate")
require("objects/world")
require("objects/cutie")
require("states/main")
require("states/menu")


Mainstate = {}


function love.load()

    ressources:addImmage("cutie0", 'gfx/cutie-0.png')
    ressources:addImmage("cutie1", 'gfx/cutie-1.png')
    ressources:addImmage("cutie2", 'gfx/cutie-2.png')
    ressources:addImmage("cutie3", 'gfx/cutie-3.png')
    ressources:addImmage("cutie4", 'gfx/cutie-4.png')
    ressources:addImmage("cutie5", 'gfx/cutie-5.png')
    ressources:addImmage("arena", 'gfx/arena.png')

    love.graphics.setMode(1000, 600, false, true, 0) -- Fensteroberfläche

end

