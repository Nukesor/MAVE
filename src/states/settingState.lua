require("core/resources")
require("core/state")

--Events
require("events/mousePressed")
require("events/mouseReleased")
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
require("systems/ui/settingNavigationSystem")
require("systems/draw/stringDrawSystem")

SettingState = class("SettingState", State)

function SettingState:initialize()
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
                Saves:refreshSettings()
                self:load()
                Saves:saveSettings()
            end
        else
            if set.resolutions[index-1] then
                set.settings.resolution = set.resolutions[index-1]
                Saves:refreshSettings()
                self:load()
                Saves:saveSettings()
            end
        end 
       end , "Resolution"},
    {function (val) 
        if set.settings.fullscreen == true then
            set.settings.fullscreen = false
        else
            set.settings.fullscreen = true
        end
        Saves:refreshSettings()
        Saves:saveSettings()
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
                                  gameplay:initialize()  
                                  Saves:saveGame() end )) end, "Reset Game"},
    {function () stack:popload() end, "Return"}
    }
end

function SettingState:load()

    self.engine = Engine()
    self.eventmanager = EventManager()
    local settingnavigation = SettingNavigationSystem()
    local boxclick = BoxClickSystem()
    self.eventmanager:addListener("KeyPressed", {settingnavigation, settingnavigation.fireEvent})
    self.eventmanager:addListener("MousePressed", {boxclick, boxclick.mousePressed})
    self.eventmanager:addListener("MouseReleased", {boxclick, boxclick.mouseReleased})

    self.engine:addSystem(BoxHoverSystem(), "logic", 1)
    self.engine:addSystem(MenuBoxDrawSystem(), "draw", 2)
    self.engine:addSystem(DrawableDrawSystem(), "draw", 1)
    self.engine:addSystem(boxclick)
    self.engine:addSystem(settingnavigation)
    self.engine:addSystem(StringDrawSystem(), "draw", 3)

    local bg = Entity()
    bg:add(DrawableComponent(resources.images.background, 0, 1, 1, 0, 0))
    bg:add(ZIndex(100))
    bg:add(PositionComponent(0, 0))
    self.engine:addEntity(bg)

    self.menunumber = 3
    self.menuboxes = {}

    -- Add Buttons
    for k, v in pairs(self.menu) do
        y = ((love.graphics.getHeight()/(#self.menu+1))*k) - 0.5 * (love.graphics.getHeight()/(#self.menu+1))
        x = love.graphics.getWidth() * (1/10)
        local box
        if k == 1 then
            box = MenuBoxModel(x, y, self.menu[k][2], self.font, self.menu[k][1], true)
        else
            box = MenuBoxModel(x, y, self.menu[k][2], self.font, self.menu[k][1], false)
        end
        self.engine:addEntity(box)
    end

    Menu:sortMenuVertical(self.menuboxes)
    love.graphics.setFont(self.font)
end


function SettingState:update(dt)
    self.engine:update(dt)
end


function SettingState:draw()
    self.engine:draw()
end


function SettingState:keypressed(key, isrepeat)
    self.eventmanager:fireEvent(KeyPressed(key, isrepeat))
end

function SettingState:mousepressed(x, y, button)
    self.eventmanager:fireEvent(MousePressed(x, y, button))
end

function SettingState:mousereleased(x, y, button)
    self.eventmanager:fireEvent(MouseReleased(x, y, button))
end