require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")

--Events
require("core/events/mousePressed")
require("core/events/keyPressed")

-- BoxComponents
require("components/userinterface/uiStringComponent")
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

require("systems/draw/stringDrawSystem")
require("components/graphic/stringComponent")


MenuState = class("MenuState", State)

function MenuState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function () stack:push(credits) end, "Credits"},
    {function () stack:push(selectstate) end, "Play"},
    {function () love.event.quit() end, "Exit"}
    }
end

function MenuState:load()

    self.engine = Engine()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.engine:addListener("KeyPressed", boxnavigation)
    self.engine:addListener("MousePressed", boxclick)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(BoxDrawSystem(), "draw")
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.engine:addSystem(StringDrawSystem(), "draw")

    self.menunumber = 3
    self.menuboxes = {}

    -- Add Buttons
    for i = 1, self.menunumber, 1 do
        y = 420
        x = (love.graphics.getWidth()*i/4)-(self.font:getWidth(self.menu[i][2])/2)
        local box
        if i == 2 then
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end

    self.timer = 0
    str = Entity()
    str:addComponent(StringComponent(resources.fonts.twenty, "ExtremeRofl, show that stuff:    %i", {{stack:current(), "timer"}}))
    str:addComponent(PositionComponent(100, 100))
    self.engine:addEntity(str)

    sortMenu(self.menuboxes)
    love.graphics.setFont(self.font)
end


function MenuState:update(dt)
    self.engine:update(dt)
    self.timer = self.timer + 1
end


function MenuState:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(resources.images.cutie2, love.graphics.getWidth()/2, 400, 0, 1, 1, resources.images.cutie2:getWidth()/2, resources.images.cutie2:getHeight())
    self.engine:draw()

    -- Draw title
    love.graphics.setFont(resources.fonts.sixty)
    love.graphics.print("MAVE", 
        (love.graphics.getWidth()-resources.fonts.sixty:getWidth("MAVE"))/2, 50, 0, 1, 1, 0, 0)
end


function MenuState:keypressed(key, u)
    self.engine:fireEvent(KeyPressed(key, u))
end

function MenuState:mousepressed(x, y, button)
    self.engine:fireEvent(MousePressed(x, y, button))
end
