require("events/buyBoolEvent")
require("components/cutie/itemComponent")
require("models/waves")

Gameplay = class("Gameplay")

function Gameplay:__init()
    self.stats = {
                    time = 0,
                    highscore = 0,
                    level = 1,
                    kills = 0,
                    blood = 100
                    }
    self.items = {
        --String, gekauft, Kosten, image, scalingx, scalingy, function 
        ItemComponent("Gewehr", true, 10, resources.images.gun, 0.15, 0.15, 1,
        function()
            -- Erstellt ein neues Shotmodel
            if playercutie:getComponent("ItemComponent").counttimer < 0 then
                local shot = ShotModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y, love.mouse.getPosition())
                shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
                stack:current().engine:addEntity(shot)
                playercutie:getComponent("ItemComponent").counttimer = playercutie:getComponent("ItemComponent").timer
            end
        end)
        ,
        ItemComponent("Granate", false, 10, resources.images.grenade, 0.12, 0.12, 0,5,
        function()
            -- Generates a new Grenademodel
            if playercutie:getComponent("ItemComponent").counttimer < 0 then
                local grenade = GrenadeModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y, love.mouse.getPosition())
                grenade:getComponent("PhysicsComponent").fixture:setUserData(grenade)
                stack:current().engine:addEntity(grenade)
                playercutie:getComponent("ItemComponent").counttimer = playercutie:getComponent("ItemComponent").timer
            end
        end)
        ,
        ItemComponent("Mine", true, 10, resources.images.mine, 0.2, 0.2, 1,
        function()
            if playercutie:getComponent("ItemComponent").counttimer < 0 then
                local mine = MineModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y)
                mine:getComponent("PhysicsComponent").fixture:setUserData(mine)
                stack:current().engine:addEntity(mine)
                playercutie:getComponent("ItemComponent").counttimer = playercutie:getComponent("ItemComponent").timer
            end
        end),
        ItemComponent("Machinegun", true, 10, resources.images.gun, 0.15, 0.15, 0.0001,
        function()
            -- Erstellen eines neuen Shotmodels
            if playercutie:getComponent("ItemComponent").counttimer < 0 then
                local shot = ShotModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y, love.mouse.getPosition())
                shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
                stack:current().engine:addEntity(shot)
                playercutie:getComponent("ItemComponent").counttimer = playercutie:getComponent("ItemComponent").timer
            end
        end)
    }

    self.waves = {
        Wave1()
    }
end
