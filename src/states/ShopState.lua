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
require("components/userinterface/menuWobblyComponent")

-- Systems
require("systems/userinterface/boxClickSystem")
require("systems/userinterface/boxDrawSystem")
require("systems/userinterface/boxHoverSystem")
require("systems/userinterface/boxNavigationSystem")
require("systems/userinterface/menuWobblySystem")


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
    engine:addSystem(MenuWobblySystem(), "logic", 2)
    engine:addSystem(BoxDrawSystem(), "draw")
    engine:addSystem(boxclick)
    engine:addSystem(boxnavigation)

    self.boxnumber = 10
    self.menunumber = 3
    self.boxes = {}
    self.menuboxes = {}
    self.width = 5

    -- Dynamische Erstellung der Item boxes
    for i = 1, self.boxnumber, 1 do

        local boxwidth = 150
        local boxheight = 75
        local box

        -- Berrechnung der Position und Zeilenumbruch nach i == self.width Boxes
        y = 50 + (math.floor((i-1)/self.width)*100)
        x = 25 + 200 * ((i-1)-math.floor((i-1)/self.width)*5)
        if i == self.boxnumber then
            box = Entity()
            box:addComponent(BoxComponent(boxwidth, boxheight, {self.boxes[i-1], nil}, "item"))
            box:addComponent(FunctionComponent(function ()
                                                       stack:pop()
                                                end
                                                    ))
            self.boxes[1]:getComponent("BoxComponent").linked[1] = box 
            box:getComponent("BoxComponent").linked[2] = self.boxes[1] 
            self.boxes[i-1]:getComponent("BoxComponent").linked[2] = box
            table.insert(self.boxes, box)

        elseif i == 1 then 
            box = Entity()
            box:addComponent(BoxComponent(boxwidth, boxheight, {nil, nil}, "item"))
            box:addComponent(FunctionComponent(function ()
                                                       stack:pop()
                                                end
                                                    ))
            table.insert(self.boxes, box)

        else
            box = Entity()
            box:addComponent(BoxComponent(boxwidth, boxheight, {self.boxes[i-1],nil}, "item"))
            box:addComponent(FunctionComponent(function ()
                                                    stack:pop()
                                                end
                                                    ))
            self.boxes[i-1]:getComponent("BoxComponent").linked[2] = box
            table.insert(self.boxes, box)
        end
        box:addComponent(PositionComponent(x, y))
        engine:addEntity(box)
    end
    -- Erstellung der MenuBoxes
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
            box:addComponent(MenuWobblyComponent())
            box:getComponent("BoxComponent").selected = true
            table.insert(self.menuboxes, box)
        elseif i == 3 then
            box:addComponent(BoxComponent(100, 40, {self.menuboxes[i-1], nil}, "menu"))
            box:addComponent(StringComponent("Exit", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     return love.event.quit() 
                                                end))
            box:addComponent(MenuWobblyComponent())
            self.menuboxes[1]:getComponent("BoxComponent").linked[1] = box 
            box:getComponent("BoxComponent").linked[2] = self.menuboxes[1] 
            self.menuboxes[i-1]:getComponent("BoxComponent").linked[2] = box
            table.insert(self.menuboxes, box)
        else

            box:addComponent(BoxComponent(100, 40, {self.menuboxes[i-1], nil}, "menu"))
            box:addComponent(StringComponent("Back", resources.fonts.forty))
            box:addComponent(FunctionComponent( function()
                                                     return stack:pop() 
                                                end))
            box:addComponent(MenuWobblyComponent())
            self.menuboxes[i-1]:getComponent("BoxComponent").linked[2] = box
            table.insert(self.menuboxes, box)
        end
        box:addComponent(PositionComponent(x, y))
        engine:addEntity(box)
    end

    -- Verlinkung der MenuBoxes mit normalen Boxes
    for i, box in ipairs(self.menuboxes) do
        box:getComponent("BoxComponent").linked[3] = self.boxes[8]
        box:getComponent("BoxComponent").linked[4] = self.boxes[3]
    end

    --Verlinkung der Boxen unter und uebereinander und Verlinkung mit Menuboxes
    for i, box in ipairs(self.boxes) do
        if self.boxes[i-self.width] and (i - self.width) >= 0 then
            box:getComponent("BoxComponent").linked[3] = self.boxes[i - self.width]
        elseif (i - self.width) < 1 and self.boxes[i - self.width + self.boxnumber] then
            box:getComponent("BoxComponent").linked[3] = self.menuboxes[2]
        end

        if self.boxes[i + self.width] and (i + self.width) <= self.boxnumber then
                box:getComponent("BoxComponent").linked[4] = self.boxes[(i+self.width)]
        elseif (i + self.width) > self.boxnumber and self.boxes[i + self.width - self.boxnumber] then
            box:getComponent("BoxComponent").linked[4] = self.menuboxes[2]
        end
    end

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