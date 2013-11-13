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
                    blood = 5,
                    owned = {}
                    }
    self.items = {
        --String, gekauft, Kosten, image, scalingx, scalingy, function 
        ItemComponent(1, "Gewehr", false, 15, resources.images.gun, 0.15, 0.15, 0.25,
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
        ItemComponent(2, "Granate", false, 50, resources.images.grenade, 0.12, 0.12, 0.5,
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
        ItemComponent(3, "Mine", false, 80, resources.images.mine, 0.2, 0.2, 1,
        function()
            if playercutie:getComponent("ItemComponent").counttimer < 0 then
                local mine = MineModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y)
                mine:getComponent("PhysicsComponent").fixture:setUserData(mine)
                stack:current().engine:addEntity(mine)
                playercutie:getComponent("ItemComponent").counttimer = playercutie:getComponent("ItemComponent").timer
            end
        end),
        ItemComponent(4, "Machinegun", false, 200, resources.images.gun, 0.15, 0.15, 0.05,
        function()
            -- Erstellen eines neuen Shotmodels
            if playercutie:getComponent("ItemComponent").counttimer < 0 then
                local shot = ShotModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y, love.mouse.getPosition())
                shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
                stack:current().engine:addEntity(shot)
                playercutie:getComponent("ItemComponent").counttimer = playercutie:getComponent("ItemComponent").timer
            end
        end),
        ItemComponent(5, "Rocketlauncher", false, 300, resources.images.gun, 0.15, 0.15, 0.8,
        function()
            -- Erstellen eines neuen Rocketmodels
            if playercutie:getComponent("ItemComponent").counttimer < 0 then
                local rocket = RocketModel(playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y, love.mouse.getPosition())
                rocket:getComponent("PhysicsComponent").fixture:setUserData(rocket)
                stack:current().engine:addEntity(rocket)
                playercutie:getComponent("ItemComponent").counttimer = playercutie:getComponent("ItemComponent").timer
            end
        end)
    }
    for i, v in pairs(self.items) do
        self.stats.owned[i] = v.owned
    end
    
    self.waves = {
        Wave1()
    }
end
