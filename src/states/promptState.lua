require("events/buyBoolEvent")

PromptState = class("PromptState", State)

function PromptState:__init(func)
    self.func = func
    self.font = resources.fonts.fifty
    self.menu = {
    {function () stack:pop()
                func() end, "Yes"},
    {function () stack:pop()
                func() end, "No"}
    }
end

function PromptState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", boxnavigation)
    self.eventmanager:addListener("MousePressed", boxclick)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(BoxDrawSystem(), "draw")
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.menunumber = 2
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics.getHeight() * (5/6)
        x = love.graphics.getWidth()/3 * (i) - 50
        local box
        if i == 1 then
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    sortMenu(self.menuboxes)

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


function PromptState:keypressed(key, u)
    self.eventmanager:fireEvent(KeyPressed(key, u))
end

function PromptState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end
