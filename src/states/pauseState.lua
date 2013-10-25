PauseState = class("PauseState", State)

function PauseState:__init()
    self.font = resources.fonts.thirty
    self.menu = {
    {function () stack:pop() saveGame() end, "Return"},
    {function () saveGame() end, "Save"},
    {function () stack:pop() stack:popload()  saveGame() end, "Level Select"},
    {function () love.event.quit() saveGame() end, "Exit"}
    }
end

function PauseState:load()

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

    for i = 1, #self.menu, 1 do
        y = i * (love.graphics.getHeight()/8)
        x = love.graphics:getWidth()/12
        local box
        if i == 1 then
            box = BoxModel(100, 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = BoxModel(100, 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    sortMenuVertical(self.menuboxes)
        
    local background = Entity()
    background:addComponent(DrawableComponent(self.screenshot))
    background:addComponent(PositionComponent(0, 0))
    background:addComponent(ZIndex(1))
    self.engine:addEntity(background)

    love.graphics.setFont(self.font)
end

function PauseState:update(dt)
    self.engine:update(dt)
end

function PauseState:draw()
    self.engine:draw()
end

function PauseState:keypressed(key, unicode)
    self.eventmanager:fireEvent(KeyPressed(key,unicode))
end

function PauseState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end