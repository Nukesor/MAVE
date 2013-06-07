require("core/helper")
require("core/system")
require("core/physicshelper")
require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")
require("core/event")

--Events
require("core/events/mousePressed")
require("core/events/keyPressed")

-- BoxComponents
require("components/boxComponent")
require("components/positionComponent")

-- Systems
require("systems/boxClickSystem")
require("systems/boxDrawSystem")
require("systems/boxHoverSystem")
require("systems/boxNavigationSystem")


ShopState = class("ShopState", State)

function ShopState:__init()
    self.font = resources.fonts.default
end

function ShopState:load()

    engine = Engine()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    engine:addListener("KeyPressed", boxnavigation)
    engine:addListener("MousePressed", boxclick)

    engine:addSystem(BoxHoverSystem(), "logic", 1)
    engine:addSystem(BoxDrawSystem(), "draw")
    engine:addSystem(boxclick)
    engine:addSystem(boxnavigation)

    self.backup = nil
    self.backupone = nil


    --item boxes
    for i = 1, 3, 1 do
        y = 50
        x = 50 + 150 * (i-1)
        local box = Entity()
        if i==1 then
            box:addComponent(BoxComponent(100, 40, {nil, nil}, function() return stack:pop() end, "item"))
        elseif i==3 then
            box:addComponent(BoxComponent(100, 40, {box, backupone}, function() stack:pop() end, "item"))
            self.backupone:getComponent("BoxComponent").linked[1] = box 
            self.backup:getComponent("BoxComponent").linked[2] = box 
        else
            box:addComponent(BoxComponent(100, 40, {box, nil}, function() stack:pop() end, "item"))
            self.backup:getComponent("BoxComponent").linked[1] = box 
        end
        box:addComponent(PositionComponent(x, y))
        engine:addEntity(box)
        if i == 1 then 
            self.backupone = box
        end
        self.backup = box
    end

    self.backup = nil
    self.backupone = nil
    -- menu boxes
    for i = 1, 3, 1 do
        y = 300
        x = 50 + 200 * (i-1)
        local box = Entity()
        if i == 1 then
            box:addComponent(BoxComponent(100, 40, {nil, nil}, function() return stack:pop() end, "menu", "zurueck"))
            box:getComponent("BoxComponent").selected = true
        elseif i == 2 then
            box:addComponent(BoxComponent(100, 40, {self.backup, nil}, function() stack:pop() end, "menu", "zurueck"))
            self.backup:getComponent("BoxComponent").linked[2] = box 
        elseif i == 3 then
            box:addComponent(BoxComponent(100, 40, {self.backup, self.backupone}, function() love.event.quit() end, "menu", "Exit"))
            self.backupone:getComponent("BoxComponent").linked[1] = box 
            self.backup:getComponent("BoxComponent").linked[2] = box 
        end
        box:addComponent(PositionComponent(x, y))
        engine:addEntity(box)
        if i == 1 then 
            self.backupone = box
        end
        self.backup = box
    end
    self.index = 1
    love.graphics.setFont(self.font)
end


function ShopState:update(dt)
    engine:update(dt)
end


function ShopState:draw()
    engine:draw()
end


function ShopState:keypressed(key, u)
    engine:fireEvent(KeyPressed(key, u))
end

function ShopState:mousepressed(x, y, button)
    engine:fireEvent(MousePressed(x, y, button))
end