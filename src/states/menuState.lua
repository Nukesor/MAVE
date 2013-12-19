require("core/resources")
require("core/state")
require("lib/lua-lovetoys/lovetoys/entity")
require("lib/lua-lovetoys/lovetoys/engine")
require("lib/lua-lovetoys/lovetoys/eventManager")

--Events
require("events/mousePressed")
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

MenuState = class("MenuState", State)

function MenuState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function () loadGame() 
                 stack:push(ShopState()) end , "Play"},
    {function () stack:push(SettingState()) end, "Settings"},
    {function () stack:push(CreditsState()) end, "Credits"},
    {function () saveGame()
                 love.event.quit() end, "Exit"}
    }
end

function MenuState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", {boxnavigation, boxnavigation.fireEvent})
    self.eventmanager:addListener("MousePressed", {boxclick, boxclick.fireEvent})

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    
    self.engine:addSystem(MenuBoxDrawSystem(), "draw", 2)
    self.engine:addSystem(DrawableDrawSystem(), "draw", 1)
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    local bg = Entity()
    bg:addComponent(DrawableComponent(resources.images.background, 0, 1, 1, 0, 0))
    bg:addComponent(ZIndex(0))
    bg:addComponent(PositionComponent(0, 0))
    self.engine:addEntity(bg)

    local logo = Entity()
    logo:addComponent(DrawableComponent(resources.images.logo, 0, 1, 1, 0, 0))
    logo:addComponent(ZIndex(1))
    logo:addComponent(PositionComponent(100, 100))
    self.engine:addEntity(logo)

    self.menunumber = #self.menu
    self.menuboxes = {}

    -- Add Buttons
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

    sortMenuVertical(self.menuboxes)
    love.graphics.setFont(self.font)
end


function MenuState:update(dt)
    self.engine:update(dt)
end


function MenuState:draw()
    love.graphics.setColor(255, 255, 255)
    self.engine:draw()

    -- Draw title
    love.graphics.setFont(resources.fonts.sixty)
end


function MenuState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

function MenuState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end
