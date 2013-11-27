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
require("components/ui/menuWobblyComponent")

-- Systems
require("systems/ui/boxClickSystem")
require("systems/ui/menuBoxDrawSystem")
require("systems/ui/boxHoverSystem")
require("systems/ui/settingNavigationSystem")
require("systems/ui/menuWobblySystem")
require("systems/draw/stringDrawSystem")

SettingState = class("SettingState", State)

function SettingState:__init()
    self.font = resources.fonts.forty
    self.menu = {
    {function (val) 
        local index
        for k, v in pairs(set.resolutions) do
            if equals(v, set.settings.resolution) then
                index = k
                break
            end
        end
        if val == "add" then
            if set.resolutions[index+1] then
                set.settings.resolution = set.resolutions[index+1]
                love.graphics.setMode(set.settings.resolution[1], set.settings.resolution[2], set.settings.fullscreen, true, 0)
                self:load()
                saveSettings()
            end
        else
            if set.resolutions[index-1] then
                set.settings.resolution = set.resolutions[index-1]
                love.graphics.setMode(set.settings.resolution[1], set.settings.resolution[2], set.settings.fullscreen, true, 0)
                self:load()
                saveSettings()
            end
        end 
       end , "Resolution"},
    {function (val) 
        if set.settings.fullscreen == true then
            set.settings.fullscreen = false
        else
            set.settings.fullscreen = true
        end
        love.graphics.setMode(set.settings.resolution[1], set.settings.resolution[2], set.settings.fullscreen, true, 0)
        saveSettings()
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
    {function ()  stack:push(PromptState(function()
                                  gameplay:__init()  
                                  saveGame() end )) end, "Reset Game"},
    {function () stack:popload() end, "Return"}
    }
end

function SettingState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local settingnavigation = SettingNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", {settingnavigation, settingnavigation.fireEvent})
    self.eventmanager:addListener("MousePressed", {boxclick, boxclick.fireEvent})

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuWobblySystem(), "logic", 2)
    self.engine:addSystem(MenuBoxDrawSystem(), "draw")
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
            box = menuBox(self.font:getWidth(self.menu[k][2]), 40, x, y, self.menu[k][2], self.font, self.menu[k][1], true)
        else
            box = menuBox(self.font:getWidth(self.menu[k][2]), 40, x, y, self.menu[k][2], self.font, self.menu[k][1], false)
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
    self.eventmanager:fireEvent(KeyPressed(key, u))
end

function SettingState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end
