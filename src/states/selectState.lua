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

--Models
require("models/boxModel")

SelectState = class("SelectState", State)

function SelectState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function () stack:push(levelOne) end , "Level1"},
    {function () stack:push(levelOne) end , "Level2"},
    {function () stack:push(shop) end , "Shop"},
    {function () stack:popload() end, "Main Menu"}
    }
end

function SelectState:load()
    love.graphics.setFont(self.font)
end

function SelectState:load()
    self.engine = Engine()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.engine:addListener("KeyPressed", boxnavigation)
    self.engine:addListener("MousePressed", boxclick)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(BoxDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.menunumber = 4
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics.getHeight() * (5/6)
        x = (love.graphics.getWidth()*i/(self.menunumber+1))-(self.font:getWidth(self.menu[i][2])/2)
        local box
        if i == 2 then
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    sortMenu(self.menuboxes)
    love.graphics.setFont(self.font)

    self.bg = Entity()
    self.bg:addComponent(DrawableComponent(resources.images.background, 0, relationx(), relationy(), 0, 0))
    self.bg:addComponent(PositionComponent(0, 0))
    self.bg:addComponent(ZIndex(0))
    self.engine:addEntity(self.bg)
end


function SelectState:update(dt)
    self.engine:update(dt)
end


function SelectState:draw()
    self.engine:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(resources.images.cutie3, love.graphics.getWidth()/2, love.graphics.getHeight() * (3/6), 0, 1, self.yscale,
        resources.images.cutie2:getWidth()/2, resources.images.cutie2:getHeight())
    love.graphics.setFont(resources.fonts.sixty)
--    love.graphics.print("Select a level or start SHOPPING", 
--        (love.graphics.getWidth()-resources.fonts.sixty:getWidth("Select a Level or start SHOPPING"))/2, 50, 0, 1, 1, 0, 0)
end


function SelectState:keypressed(key, u)
    self.engine:fireEvent(KeyPressed(key, u))
end

function SelectState:mousepressed(x, y, button)
    self.engine:fireEvent(MousePressed(x, y, button))
end