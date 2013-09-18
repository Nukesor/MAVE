require("core/events/buyBoolEvent")
require("components/cutie/itemComponent")

Gameplay = class("Gameplay")

function Gameplay:__init()
    self.time = 0
    self.highscore = 0
    self.level = 1
    self.kills = 0

    self.gold = 100
    self.items = {
        --String, gekauft, Kosten, image, scalingx, scalingy, function 
        ItemComponent("Gewehr", true, 10, resources.images.gun, 0.1, 0.1,
        function()
            -- Erstellt ein neues Shotmodel
            local shot = ShotModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y, love.mouse.getPosition())
            shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
            stack:current().engine:addEntity(shot) 
        end)
        ,
        ItemComponent("Granate", true, 10, resources.images.grenade, 0.07, 0.07, 
        function()
            -- Generates a new Grenademodel
            local grenade = GrenadeModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y, love.mouse.getPosition())
            grenade:getComponent("PhysicsComponent").fixture:setUserData(grenade)
            stack:current().engine:addEntity(grenade)
        end)
        ,
        ItemComponent("Mine", true, 10, resources.images.grenade, 0.07, 0.07,
        function()
            local mine = MineModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y)
            mine:getComponent("PhysicsComponent").fixture:setUserData(mine)
            stack:current().engine:addEntity(mine)
        end)
        ,
        ItemComponent("Hammer", false, 100, resources.images.grenade, 0.07, 0.07, 
        function()
        end)
    }
    self.resolutions = {{1024, 576}, {1280, 720}, {1366, 768}, {1600, 900}, {1920, 1080}}
    self.settings = {
    resolution = {1920, 1080},
    fullscreen = false,
    audio = 100,
    music = 100,
    mousespeed = 1,
    }
end