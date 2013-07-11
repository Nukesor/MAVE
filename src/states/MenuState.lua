require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")
require("core/event")

--Events
require("core/events/mousePressed")
require("core/events/keyPressed")

-- BoxComponents
require("components/userinterface/stringComponent")
require("components/userinterface/boxComponent")
require("components/physic/positionComponent")
require("components/userinterface/functionComponent")
require("components/userinterface/imageComponent")
require("components/userinterface/menuWobblyComponent")

-- Systems
require("systems/userinterface/boxClickSystem")
require("systems/userinterface/boxDrawSystem")
require("systems/userinterface/boxHoverSystem")
require("systems/userinterface/boxNavigationSystem")
require("systems/userinterface/menuWobblySystem")


MenuState = class("MenuState", State)

function MenuState:__init()
    self.font = resources.fonts.big
end

function MenuState:load()

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

    for i = 1, 3, 1 do
        y = 500
        x = love.graphics.getWidth()/4 * (i)
        local box = Entity()
        if i == 1 then
            box:addComponent(BoxComponent(100, 40, {nil, nil}, "menu"))
            box:addComponent(StringComponent("Credits", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     stack:push(credits)
                                                end))
            box:addComponent(MenuWobblyComponent())
            table.insert(self.menuboxes, box)
        elseif i == 3 then
            box:addComponent(BoxComponent(100, 40, {self.menuboxes[i-1], nil}, "menu"))
            box:addComponent(StringComponent("Exit", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     love.event.quit()
                                                end))
            box:addComponent(MenuWobblyComponent())
            self.menuboxes[1]:getComponent("BoxComponent").linked[1] = box 
            box:getComponent("BoxComponent").linked[2] = self.menuboxes[1] 
            self.menuboxes[i-1]:getComponent("BoxComponent").linked[2] = box
            table.insert(self.menuboxes, box)
        else

            box:addComponent(BoxComponent(100, 40, {self.menuboxes[i-1], nil}, "menu"))
            box:addComponent(StringComponent("Play", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     stack:push(selectstate)
                                                end))
            box:addComponent(MenuWobblyComponent())
            self.menuboxes[i-1]:getComponent("BoxComponent").linked[2] = box
            box:getComponent("BoxComponent").selected = true
            table.insert(self.menuboxes, box)
        end
        box:addComponent(PositionComponent(x, y))
        engine:addEntity(box)
    end

    love.graphics.setFont(self.font)
end


function MenuState:update(dt)
    engine:update(dt)
end


function MenuState:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(resources.images.cutie2, love.graphics.getWidth()/2, 400, 0, 1, 1, resources.images.cutie2:getWidth()/2, resources.images.cutie2:getHeight())
    engine:draw()
end


function MenuState:keypressed(key, u)
    engine:fireEvent(KeyPressed(key, u))
end

function MenuState:mousepressed(x, y, button)
    engine:fireEvent(MousePressed(x, y, button))
end
