require("core/resources")
require("core/state")
require("core/entity")
require("core/engine")

--Events
require("core/events/mousePressed")
require("core/events/keyPressed")

-- BoxComponents
require("components/userinterface/uiStringComponent")
require("components/userinterface/boxComponent")
require("components/physic/positionComponent")
require("components/userinterface/functionComponent")
require("components/userinterface/imageComponent")
require("components/userinterface/menuWobblyComponent")

-- Systems
require("systems/userinterface/boxClickSystem")
require("systems/userinterface/boxDrawSystem")
require("systems/userinterface/boxHoverSystem")
require("systems/userinterface/settingNavigationSystem")
require("systems/userinterface/menuWobblySystem")
require("systems/draw/stringDrawSystem")

SettingState = class("SettingState", State)

function SettingState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function (val) 
        local index
        for k, v in pairs(gameplay.resolutions) do
            if equals(v, gameplay.settings.resolution) then
                index = k
                break
            end
        end
        if val == "add" then
            if gameplay.resolutions[index+1] then
                gameplay.settings.resolution = gameplay.resolutions[index+1]
            love.graphics.setMode(gameplay.settings.resolution[1], gameplay.settings.resolution[2], gameplay.settings.fullscreen, true, 0)
            self:load()
            end
        else
            if gameplay.resolutions[index-1] then
                gameplay.settings.resolution = gameplay.resolutions[index-1]
                love.graphics.setMode(gameplay.settings.resolution[1], gameplay.settings.resolution[2], gameplay.settings.fullscreen, true, 0)
                self:load()
            end
        end 
       end , "Resolution"},
    {function (val) 
        if gameplay.settings.fullscreen == true then
            gameplay.settings.fullscreen = false
        else
            gameplay.settings.fullscreen = true
        end
        love.graphics.setMode(gameplay.settings.resolution[1], gameplay.settings.resolution[2], gameplay.settings.fullscreen, true, 0)
    end , "Fullscreen"},
    {function (val) 
        if val == "add" then

        else

        end 
       end , "Sound"},
    {function (val) 
        if val == "add" then

        else

        end 
       end , "Music"},
    {function (val) 
        if val == "add" then

        else

        end 
       end , "Mousespeed"},
    {function () stack:popload() end, "Return"}
    }
end

function SettingState:load()

    self.engine = Engine()
    local settingnavigation = SettingNavigationSystem()
    local boxclick = BoxClickSystem()
    self.engine:addListener("KeyPressed", settingnavigation)
    self.engine:addListener("MousePressed", boxclick)

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(BoxDrawSystem(), "draw")
    self.engine:addSystem(DrawableDrawSystem(), "draw")
    self.engine:addSystem(boxclick)
    self.engine:addSystem(settingnavigation)
    self.engine:addSystem(StringDrawSystem(), "draw")

    self.menunumber = 3
    self.menuboxes = {}

    -- Add Buttons
    for k, v in pairs(self.menu) do
        y = ((love.graphics.getHeight()/(#self.menu+1))*k) - 0.5 * (love.graphics.getHeight()/(#self.menu+1))
        x = love.graphics.getWidth() * (1/10)
        local box
        if k == 1 then
            box = BoxModel(self.font:getWidth(self.menu[k][2]), 40, x, y, "menu", self.menu[k][2], self.font, self.menu[k][1], true)
        else
            box = BoxModel(self.font:getWidth(self.menu[k][2]), 40, x, y, "menu", self.menu[k][2], self.font, self.menu[k][1], false)
        end
        self.engine:addEntity(box)
    end

    sortMenuVertical(self.menuboxes)
    love.graphics.setFont(self.font)
end


function SettingState:update(dt)
    self.engine:update(dt)
end


function SettingState:draw()
    self.engine:draw()
end


function SettingState:keypressed(key, u)
    self.engine:fireEvent(KeyPressed(key, u))
end

function SettingState:mousepressed(x, y, button)
    self.engine:fireEvent(MousePressed(x, y, button))
end
