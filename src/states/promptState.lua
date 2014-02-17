require("events/buyBoolEvent")
require("events/mouseReleased")

PromptState = class("PromptState", State)

function PromptState:__init(func)
    self.func = func
    self.font = resources.fonts.fifty
    self.menu = {
    {function () stack:pop()
                func() end, "Yes"},
    {function () stack:pop() end, "No"}
    }
end

function PromptState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", {boxnavigation, boxnavigation.fireEvent})
    self.eventmanager:addListener("MousePressed", {boxclick, boxclick.mousePressed})
    self.eventmanager:addListener("MouseReleased", {boxclick, boxclick.mouseReleased})

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuBoxDrawSystem(), "draw", 2)
    self.engine:addSystem(DrawableDrawSystem(), "draw", 1)
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.menunumber = 2
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics.getHeight() * (5/6)
        x = love.graphics.getWidth()/3 * (i) - 50
        local box
        if i == 1 then
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    Menu:sortMenu(self.menuboxes)

    love.graphics.setFont(self.font)
end


function PromptState:update(dt)
    self.engine:update(dt)
end


function PromptState:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(self.font)
    love.graphics.print("ARE YOU SURE?", love.graphics.getWidth()/2, love.graphics.getHeight() * (1/2), 0, 1, 1, self.font:getWidth("ARE YOU SURE?")/2, self.font:getHeight("ARE YOU SURE?")/2)
    self.engine:draw()
end


function PromptState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

function PromptState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end

function PromptState:mousereleased(x, y, button)
    self.eventmanager:fireEvent(MouseReleased(x, y, button))
end
