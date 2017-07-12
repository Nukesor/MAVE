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


GameOverState = class("GameOverState", State)

function GameOverState:initialize(screenshot)
    self.font = resources.fonts.forty
    self.menu = {
    {function () Saves:saveGame()
                 stack:popload() end, "Retry"},
    {function () Saves:saveGame()
                 stack:pop()
                 stack:popload() end, "Shop"},
    {function () Saves:saveGame()
                 love.event.quit() end, "Exit"}
    }
    self.screenshot = screenshot
end

function GameOverState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", {boxnavigation, boxnavigation.fireEvent})
    self.eventmanager:addListener("MousePressed", {boxclick, boxclick.mousePressed})

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(MenuBoxDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.menunumber = 3
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics:getHeight() * (5/6)
        x = love.graphics.getWidth()/4 * i -(self.font:getWidth(self.menu[i][2])/2)
        local box
        if i == 2 then
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    Menu:sortMenu(self.menuboxes)

    local background = Entity()
    background:add(DrawableComponent(self.screenshot))
    background:add(PositionComponent(0, 0))
    background:add(ZIndex(1))
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


function GameOverState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

function GameOverState:mousereleased(x, y, button)
    self.eventmanager:fireEvent(MouseReleased(x, y, button))
end

function GameOverState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end
