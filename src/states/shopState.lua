require("core/resources")
require("core/state")
require("lib/lua-lovetoys/lovetoys/entity")
require("lib/lua-lovetoys/lovetoys/engine")
require("lib/lua-lovetoys/lovetoys/eventManager")

--Events
require("events/mousePressed")
require("events/keyPressed")
require("events/buyBoolEvent")

-- BoxComponents
require("components/ui/uiStringComponent")
require("components/ui/boxComponent")
require("components/physic/positionComponent")
require("components/ui/functionComponent")
require("components/ui/imageComponent")
require("components/ui/menuWobblyComponent")

-- Systems
require("systems/ui/boxClickSystem")
require("systems/ui/menuBoxDrawSystem")
require("systems/ui/boxHoverSystem")
require("systems/ui/boxNavigationSystem")
require("systems/ui/menuWobblySystem")
require("systems/ui/itemBoxDrawSystem")
require("systems/draw/stringDrawSystem")

require("models/itemBoxModel")


ShopState = class("ShopState", State)

function ShopState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function () stack:popload() end, "Main Menu"},
    {function () stack:push(LevelOneState()) end, "Start Game"}
    }
end

function ShopState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", {boxnavigation, boxnavigation.fireEvent})
    self.eventmanager:addListener("MousePressed", {boxclick, boxclick.fireEvent})

    self.engine:addSystem(BoxHoverSystem(), "logic")
    self.engine:addSystem(MenuWobblySystem(), "logic")
    self.engine:addSystem(MenuBoxDrawSystem(), "draw")
    self.engine:addSystem(ItemBoxDrawSystem(), "draw")
    self.engine:addSystem(StringDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)

    self.boxnumber = 5
    self.boxes = {}
    self.width = 4


    local str = Entity()
    str:addComponent(StringComponent(resources.fonts.thirty, {255, 0, 0, 255}, "Blood:  %i", {{gameplay.stats, "blood"}}))
    str:addComponent(PositionComponent(10, 10))
    self.engine:addEntity(str)

    -- Dynamische Erstellung der Item boxes
    for i = 1, self.boxnumber, 1 do

        -- Berrechnung der Position und Zeilenumbruch nach i == self.width Boxes
        y = love.graphics.getHeight() * (1/20) + (math.floor((i-1)/self.width) * love.graphics.getHeight() * (1/10)) + math.floor((i-1)/self.width) * love.graphics.getHeight() * (1/30)
        x = love.graphics.getWidth() * (1/24) + love.graphics.getWidth() * (1/5) * ((i-1)-math.floor((i-1)/self.width)*self.width)

        local bwidth = love.graphics.getWidth()*(3/25)
        local bheight = love.graphics.getHeight()*(1/9)
        local box
        if gameplay.items[i] then
            local xscale
            local yscale
            if bheight / gameplay.items[i].image:getHeight() < 1 then
                yscale = bheight / gameplay.items[i].image:getHeight()
            else
                yscale = 1
            end
            if bwidth / gameplay.items[i].image:getWidth() < 1 then
                xscale = bwidth / gameplay.items[i].image:getWidth()
            else
                xscale = 1
            end
            if xscale < yscale then
                yscale = xscale
            else
                xscale = yscale
            end
            box = ItemBoxModel(i, bwidth, bheight, x, y, false, gameplay.items[i].image, xscale)
            box:addComponent(gameplay.items[i])
        else
            box = ItemBoxModel(i, bwidth, bheight, x, y, false)
            box:addComponent(gameplay.items[i])
        end
        self.engine:addEntity(box)
    end
    sortItemMenu(self.boxes, self.width)

    -- Erstellung der MenuBoxes
    self.menunumber = 2
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics.getHeight() * (7/8)
        x = (love.graphics.getWidth()*i/(self.menunumber+1))-self.font:getWidth(self.menu[i][2])/2
        local box
        if i == 2 then
            box = menuBox(self.font:getWidth(self.menu[i][2]), 40, x, y, self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = menuBox(self.font:getWidth(self.menu[i][2]), 40, x, y, self.menu[i][2], self.font, self.menu[i][1], false)
        end        
        self.engine:addEntity(box)
    end
    sortMenu(self.menuboxes)

    -- Verlinkung der MenuBoxes mit normalen Boxes
    for i, box in ipairs(self.menuboxes) do
        box:getComponent("BoxComponent").linked[3] = self.boxes[self.boxnumber]
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
end

function ShopState:update(dt)
    self.engine:update(dt)
end


function ShopState:draw()
    self.engine:draw()
end


function ShopState:keypressed(key, u)
    self.eventmanager:fireEvent(KeyPressed(key, u))
end

function ShopState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end