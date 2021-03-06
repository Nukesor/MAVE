-- This State will be used, if we decide to implement new levels.

require("core/resources")
require("core/state")

--Events
require("events/mousePressed")
require("events/mouseReleased")
require("events/keyPressed")

-- BoxComponents
require("components/ui/uiStringComponent")
require("components/ui/boxComponent")
require("components/physic/positionComponent")
require("components/ui/functionComponent")
require("components/ui/imageComponent")

-- Systems
require("systems/ui/boxClickSystem")
require("systems/ui/menuBoxDrawSystem")
require("systems/ui/boxHoverSystem")
require("systems/ui/boxNavigationSystem")

--Models
require("models/menuBoxModel")

SelectState = class("SelectState", State)

function SelectState:initialize()
    self.font = resources.fonts.forty
    self.menu = {
    {function () stack:push(LevelOneState()) end , "Level1"},
    {function () stack:push(LevelOneState()) end , "Level2"},
    {function () stack:push(ShopState()) end , "Shop"},
    {function () stack:popload() end, "Main Menu"}
    }
end

function SelectState:load()
    love.graphics.setFont(self.font)
end

function SelectState:load()
    
    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", boxnavigation.fireEvent)
    self.eventmanager:addListener("MousePressed", boxclick.mousePressed)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(MenuBoxDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.menunumber = 4
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics.getHeight() * (5/6)
        x = (love.graphics.getWidth()*i/(self.menunumber+1))-(self.font:getWidth(self.menu[i][2])/2)
        local box
        if i == 2 then
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    Menu:sortMenu(self.menuboxes)
    love.graphics.setFont(self.font)

    self.bg = Entity()
    self.bg:add(DrawableComponent(resources.images.background, 0, 1, 1, 0, 0))
    self.bg:add(PositionComponent(0, 0))
    self.bg:add(ZIndex(0))
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


function SelectState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

function SelectState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end

function SelectState:mousereleased(x, y, button)
    self.eventmanager:fireEvent(MouseReleased(x, y, button))
end