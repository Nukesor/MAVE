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
require("components/userinterface/stringComponent")
require("components/userinterface/boxComponent")
require("components/physic/positionComponent")
require("components/userinterface/functionComponent")
require("components/userinterface/imageComponent")

-- Systems
require("systems/userinterface/boxClickSystem")
require("systems/userinterface/boxDrawSystem")
require("systems/userinterface/boxHoverSystem")
require("systems/userinterface/boxNavigationSystem")


ShopState = class("ShopState", State)

function ShopState:__init()
    self.font = resources.fonts.forty
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

    -- item boxes
    for i = 1, 10, 1 do
        local width = 5
        local boxwidth = 150
        local boxheight = 75

        -- Die Boxes werden dynamisch eingefuegt
        y = 50 + (math.floor((i-1)/width)*100)
        x = 25 + 200 * ((i-1)-math.floor((i-1)/width)*5)
        local box = Entity()
        if i==1 then
            box:addComponent(BoxComponent(boxwidth, boxheight, {nil, nil}, "item"))
             box:addComponent(FunctionComponent(function ()
                                                    stack:pop()
                                                end
                                                    ))      
        elseif i==10 then
            box:addComponent(BoxComponent(boxwidth, boxheight, {box, backupone}, "item"))
            box:addComponent(FunctionComponent(function ()
                                                    stack:pop()
                                                end
                                                    ))
            self.backupone:getComponent("BoxComponent").linked[1] = box 
            self.backup:getComponent("BoxComponent").linked[2] = box 
        else
            box:addComponent(BoxComponent(boxwidth, boxheight, {box, nil}, "item"))
            box:addComponent(FunctionComponent(function ()
                                                    stack:pop()
                                                end
                                                    ))
            self.backup:getComponent("BoxComponent").linked[1] = box
        end

        -- Hier wird der Zeilenumbruch ab einer bestimmten Anzahl von Items angesetzt.
        box:addComponent(PositionComponent(x, y))
        if i == 1 then 
            self.backupone = box
        end
        self.backup = box
        engine:addEntity(box)
    end

    self.backup = nil
    self.backupone = nil
    -- menu boxes
    for i = 1, 3, 1 do
        y = 500
        x = love.graphics.getWidth()/4 * (i)
        local box = Entity()
        if i == 1 then
            box:addComponent(BoxComponent(100, 40, {nil, nil}, "menu"))
            box:addComponent(StringComponent("Back", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     return stack:pop() 
                                                end))
            box:getComponent("BoxComponent").selected = true
        elseif i == 2 then
            box:addComponent(BoxComponent(100, 40, {self.backup, nil}, "menu"))
            box:addComponent(StringComponent("Back", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     return stack:pop() 
                                                end))
            self.backup:getComponent("BoxComponent").linked[2] = box 
        elseif i == 3 then
            box:addComponent(BoxComponent(100, 40, {self.backup, self.backupone}, "menu"))
            box:addComponent(StringComponent("Exit", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     return love.event.quit() 
                                                end))
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