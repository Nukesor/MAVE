PauseState = class("PauseState", State)

function PauseState:__init()
    self.font = resources.fonts.thirty
end

function PauseState:load()
    engine = Engine()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    engine:addListener("KeyPressed", boxnavigation)
    engine:addListener("MousePressed", boxclick)

    engine:addSystem(BoxHoverSystem(), "logic", 1)
    engine:addSystem(MenuWobblySystem(), "logic", 2)
    engine:addSystem(BoxDrawSystem(), "draw")
    engine:addSystem(DrawableDrawSystem(), "draw")
    engine:addSystem(boxclick)
    engine:addSystem(boxnavigation)

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
        engine:addEntity(box)
    end
    sortMenu(self.menuboxes)
    love.graphics.setFont(self.font)
end

function PauseState:update(dt)
    engine:update(dt)
end

function PauseState:draw()
    engine:draw()
end

function PauseState:keypressed(key, unicode)
    engine:fireEvent(KeyPressed(key,unicode))
end

function PauseState:mousepressed(x, y, button)
    engine:fireEvent(MousePressed(x, y, button))
end