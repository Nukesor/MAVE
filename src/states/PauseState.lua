PauseState = class("PauseState", State)

function PauseState:__init()
    self.font = resources.fonts.thirty
end

function PauseState:load()
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

    self.menunumber = 3
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = (i-1) * 120 + 100
        x = 120
        local box
        if i == 1 then
            box = BoxModel(100, 40, x, y, "menu", gameplay.pauseMenu[i][2], self.font, gameplay.pauseMenu[i][1], true)
        else
            box = BoxModel(100, 40, x, y, "menu", gameplay.pauseMenu[i][2], self.font, gameplay.pauseMenu[i][1], false)
        end
        self.engine:addEntity(box)
    end
    sortMenu(self.menuboxes)
    love.graphics.setFont(self.font)
end

function PauseState:update(dt)
    self.engine:update(dt)
end

function PauseState:draw()
    self.engine:draw()
end

function PauseState:keypressed(key, unicode)
    self.engine:fireEvent(KeyPressed(key,unicode))
end

function PauseState:mousepressed(x, y, button)
    self.engine:fireEvent(MousePressed(x, y, button))
end