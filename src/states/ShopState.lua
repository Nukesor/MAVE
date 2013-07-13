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

    self.engine = Engine()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.engine:addListener("KeyPressed", boxnavigation)
    self.engine:addListener("MousePressed", boxclick)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(BoxDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.boxnumber = 10
    self.boxes = {}
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
                                                       stack:popload()
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
                                                       stack:popload()
                                                end
                                                    ))
            table.insert(self.boxes, box)

        else
            box = Entity()
            box:addComponent(BoxComponent(boxwidth, boxheight, {self.boxes[i-1],nil}, "item"))
            box:addComponent(FunctionComponent(function ()
                                                    stack:popload()
                                                end
                                                    ))
            self.boxes[i-1]:getComponent("BoxComponent").linked[2] = box
            table.insert(self.boxes, box)
        end
        box:addComponent(PositionComponent(x, y))
        self.engine:addEntity(box)
    end


    -- Erstellung der MenuBoxes
    self.menunumber = 3
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = 500
        x = love.graphics.getWidth()/4 * (i) - 50
        local box
        if i == 2 then
            box = BoxModel(100, 40, x, y, "menu", gameplay.shopMenu[i][2], self.font, gameplay.shopMenu[i][1], true)
        else
            box = BoxModel(100, 40, x, y, "menu", gameplay.shopMenu[i][2], self.font, gameplay.shopMenu[i][1], false)
        end        
        sortMenu(self.menuboxes)

        self.engine:addEntity(box)
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
    self.engine:update(dt)
end


function ShopState:draw()
    self.engine:draw()
end


function ShopState:keypressed(key, u)
    self.engine:fireEvent(KeyPressed(key, u))
end

function ShopState:mousepressed(x, y, button)
    self.engine:fireEvent(MousePressed(x, y, button))
end