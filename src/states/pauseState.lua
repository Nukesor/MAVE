PauseState = class("PauseState", State)

function PauseState:__init(screenshot)
    self.font = resources.fonts.thirty
    self.menu = {
    {function () Saves:saveGame() 
                 stack:pop() end, "Resume"},
    {function () Saves:saveGame()
                 stack:pop()
                 stack:pop()
                 stack:popload() end, "Main Menu"},
    {function () Saves:saveGame()
                 love.event.quit() end, "Exit"}
    }
    self.screenshot = screenshot
end

function PauseState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", {boxnavigation, boxnavigation.fireEvent})
    self.eventmanager:addListener("MousePressed", {boxclick, boxclick.mousePressed})
    self.eventmanager:addListener("MouseReleased", {boxclick, boxclick.mouseReleased})

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(MenuBoxDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.menuboxes = {}

    for i = 1, #self.menu, 1 do
        y = i * (love.graphics.getHeight()/8)
        x = love.graphics:getWidth()/12
        local box
        if i == 1 then
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = MenuBoxModel(x, y, self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    Menu:sortMenuVertical(self.menuboxes)
        
    local background = Entity()
    background:add(DrawableComponent(self.screenshot))
    background:add(PositionComponent(0, 0))
    background:add(ZIndex(1))
    self.engine:addEntity(background)

    love.graphics.setFont(self.font)
end

function PauseState:update(dt)
    self.engine:update(dt)
end

function PauseState:draw()
    self.engine:draw()
end

function PauseState:keypressed(key, isrepeatnicode)
    self.eventmanager:fireEvent(KeyPressed(key,unicode))
    if key == "escape" or key == "p" then
        stack:pop()
    end
end

function PauseState:keyreleased(key, isrepeat)
    self.eventmanager:fireEvent(KeyReleased(key, isrepeat))
end

function PauseState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end

function PauseState:mousereleased(x, y, button)
    self.eventmanager:fireEvent(MouseReleased(x, y, button))
end