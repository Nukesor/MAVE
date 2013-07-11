require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")
require("core/event")

--Events
require("core/events/mousePressed")
require("core/events/keyPressed")

-- BoxComponents
require("components/userinterface/stringComponent")
require("components/userinterface/boxComponent")
require("components/physic/positionComponent")
require("components/userinterface/functionComponent")
require("components/userinterface/imageComponent")
require("components/userinterface/menuWobblyComponent")

-- Systems
require("systems/userinterface/boxClickSystem")
require("systems/userinterface/boxDrawSystem")
require("systems/userinterface/boxHoverSystem")
require("systems/userinterface/boxNavigationSystem")
require("systems/userinterface/menuWobblySystem")

--Models
require("models/boxModel")

SelectState = class("SelectState", State)

function SelectState:__init()
    self.font = resources.fonts.big
end

function SelectState:load()
    love.graphics.setFont(self.font)
end

function SelectState:load()

    engine = Engine()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    engine:addListener("KeyPressed", boxnavigation)
    engine:addListener("MousePressed", boxclick)

    engine:addSystem(BoxHoverSystem(), "logic", 1)
    engine:addSystem(MenuWobblySystem(), "logic", 2)
    engine:addSystem(BoxDrawSystem(), "draw")
    engine:addSystem(DrawableDrawSystem(), "draw")
    engine:addSystem(boxclick)
    engine:addSystem(boxnavigation)

    self.menunumber = 4
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = 500
        x = love.graphics.getWidth()/5 * (i) - 50
        local box
        if i == 2 then
            box = BoxModel(100, 40, x, y, "menu", gameplay.selectMenu[i][2], resources.fonts.forty, gameplay.selectMenu[i][1], true)
        else
            box = BoxModel(100, 40, x, y, "menu", gameplay.selectMenu[i][2], resources.fonts.forty, gameplay.selectMenu[i][1], false)
        end
        engine:addEntity(box)
    end
    sortMenu(self.menuboxes)
    love.graphics.setFont(self.font)
end


function SelectState:update(dt)
    engine:update(dt)
end


function SelectState:draw()
    engine:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(resources.images.cutie3, love.graphics.getWidth()/2, 400, 0, 1, self.yscale, resources.images.cutie2:getWidth()/2, resources.images.cutie2:getHeight())
    love.graphics.print("Select a level or start SHOPPING", love.graphics.getWidth()/2 - resources.fonts.big:getWidth("Select a Level or start SHOPPING")/2, 50, 0, 1, 1, 0, 0)
end


function SelectState:keypressed(key, u)
    engine:fireEvent(KeyPressed(key, u))
end

function SelectState:mousepressed(x, y, button)
    engine:fireEvent(MousePressed(x, y, button))
end