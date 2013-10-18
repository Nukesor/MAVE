require("lib/resources")
require("lib/state")
require("core/component")
require("core/entity")
require("core/engine")
require("core/eventManager")

--Events
require("events/mousePressed")
require("events/keyPressed")

-- BoxComponents
require("components/ui/uiStringComponent")
require("components/ui/boxComponent")
require("components/physic/positionComponent")
require("components/ui/functionComponent")
require("components/ui/imageComponent")
require("components/ui/menuWobblyComponent")

-- Systems
require("systems/ui/boxClickSystem")
require("systems/ui/boxDrawSystem")
require("systems/ui/boxHoverSystem")
require("systems/ui/boxNavigationSystem")
require("systems/ui/menuWobblySystem")


GameOverState = class("GameOverState", State)

function GameOverState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function () stack:popload() end, "Retry"},
    {function () stack:pop() 
                 stack:popload() end, "Level Select"},
    {function () stack:pop()
                 stack:pop()
                 stack:push(shop) end, "Shop"}
    }
end

function GameOverState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", boxnavigation)
    self.eventmanager:addListener("MousePressed", boxclick)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(BoxDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.menunumber = 3
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics:getHeight() * (5/6)
        x = love.graphics.getWidth()/4 * i -(self.font:getWidth(self.menu[i][2])/2)
        local box
        if i == 2 then
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    sortMenu(self.menuboxes)

    local background = Entity()
    background:addComponent(DrawableComponent(self.screenshot))
    background:addComponent(PositionComponent(0, 0))
    background:addComponent(ZIndex(1))
    self.engine:addEntity(background)
end


function GameOverState:update(dt)
    self.engine:update(dt)
end


function GameOverState:draw()
    self.engine:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("You just died!", love.graphics.getWidth()/2-self.font:getWidth("You just died!")/2, 300)
    love.graphics.print("Well, that sucks...", love.graphics.getWidth()/2-self.font:getWidth("Well that sucks...")/2, 200)
end


function GameOverState:keypressed(key, u)
    self.eventmanager:fireEvent(KeyPressed(key, u))
end

function GameOverState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end
