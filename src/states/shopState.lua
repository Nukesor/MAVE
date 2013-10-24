require("lib/resources")
require("lib/state")
require("lovetoys/core/entity")
require("lovetoys/core/engine")
require("lovetoys/core/eventManager")

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
require("systems/ui/boxDrawSystem")
require("systems/ui/boxHoverSystem")
require("systems/ui/boxNavigationSystem")
require("systems/ui/menuWobblySystem")
require("systems/ui/buyEventSystem")

require("models/itemBoxModel")


ShopState = class("ShopState", State)

function ShopState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function () stack:popload() end, "Back"},
    {function () stack:pop() 
                 stack:push(levelOne) end, "Play"}
    }
end

function ShopState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local boxnavigation = BoxNavigationSystem()
    local boxclick = BoxClickSystem()
    local buyeventsystem = BuyEventSystem()
    self.eventmanager:addListener("KeyPressed", boxnavigation)
    self.eventmanager:addListener("MousePressed", boxclick)
    self.eventmanager:addListener("BuyBoolEvent", buyeventsystem)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(BoxDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(boxnavigation)
    self.engine:addSystem(buyeventsystem)

    self.boxnumber = 12
    self.boxes = {}
    self.width = 4

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
            box = ItemBoxModel(bwidth, bheight, x, y, "item", false, gameplay.items[i].image, xscale)
        else
            box = ItemBoxModel(bwidth, bheight, x, y, "item", false)
        end
        self.engine:addEntity(box)
    end
    sortMenu(self.boxes)

    -- Erstellung der MenuBoxes
    self.menunumber = 2
    self.menuboxes = {}

    for i = 1, self.menunumber, 1 do
        y = love.graphics.getHeight() * (3/4)
        x = (love.graphics.getWidth()*i/(self.menunumber+1))-self.font:getWidth(self.menu[i][2])/2
        local box
        if i == 2 then
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], true)
        else
            box = BoxModel(self.font:getWidth(self.menu[i][2]), 40, x, y, "menu", self.menu[i][2], self.font, self.menu[i][1], false)
        end        
        self.engine:addEntity(box)
    end
    sortMenu(self.menuboxes)

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
    love.graphics.setFont(resources.fonts.twenty)
    love.graphics.print(gameplay.stats["blood"] .. " Blood", 26, 10)
end


function ShopState:keypressed(key, u)
    self.eventmanager:fireEvent(KeyPressed(key, u))
end

function ShopState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end