require("events/buyBoolEvent")
require("components/cutie/itemComponent")
require("models/waves")

Gameplay = class("Gameplay")

function Gameplay:initialize()
    self.stats = {
                    time = 0,
                    highscore = 0,
                    level = 1,
                    kills = 0,
                    blood = 0,
                    owned = {}
                    }
    self.items = {
        --String, gekauft, Kosten, image, scalingx, scalingy, weaponcooldown, function 
        ItemComponent(1, "Gewehr", false, 15, resources.images.gun, 0.18, 0.18, 1.25,
        function()
            -- Erstellt ein neues Shotmodel
            local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
            if playercutie:get("ItemComponent").counttimer < 0 then
                local shot = ShotModel(playercutie:get("PositionComponent").x, playercutie:get("PositionComponent").y, 100, 4000 ,love.mouse.getPosition())
                shot:get("PhysicsComponent").fixture:setUserData(shot)
                stack:current().engine:addEntity(shot)
                playercutie:get("ItemComponent").counttimer = playercutie:get("ItemComponent").timer
            end
        end)
        ,
        ItemComponent(2, "Granate", false, 50, resources.images.grenade, 0.14, 0.14, 0.5,
        function()
            -- Generates a new Grenademodel
            local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
            if playercutie:get("ItemComponent").counttimer < 0 then
                local grenade = GrenadeModel(playercutie:get("PositionComponent").x, playercutie:get("PositionComponent").y, love.mouse.getPosition())
                grenade:get("PhysicsComponent").fixture:setUserData(grenade)
                stack:current().engine:addEntity(grenade)
                playercutie:get("ItemComponent").counttimer = playercutie:get("ItemComponent").timer
            end
        end)
        ,
        ItemComponent(3, "Mine", false, 80, resources.images.mine, 0.4, 0.4, 1,
        function()
            local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
            if playercutie:get("ItemComponent").counttimer < 0 then
                local mine = MineModel(playercutie:get("PositionComponent").x, playercutie:get("PositionComponent").y)
                mine:get("PhysicsComponent").fixture:setUserData(mine)
                stack:current().engine:addEntity(mine)
                playercutie:get("ItemComponent").counttimer = playercutie:get("ItemComponent").timer
            end
        end),
        ItemComponent(4, "Machinegun", false, 200, resources.images.gun, 0.18, 0.18, 0.1,
        function()
            -- Erstellen eines neuen Shotmodels
            local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
            if playercutie:get("ItemComponent").counttimer < 0 then
                local shot = ShotModel(playercutie:get("PositionComponent").x, playercutie:get("PositionComponent").y, 20, 2000, love.mouse.getPosition())
                shot:get("PhysicsComponent").fixture:setUserData(shot)
                stack:current().engine:addEntity(shot)
                playercutie:get("ItemComponent").counttimer = playercutie:get("ItemComponent").timer
            end
        end),
        ItemComponent(5, "Rocketlauncher", false, 300, resources.images.rocketlauncher, 0.05, 0.05, 0.8,
        function()
            -- Erstellen eines neuen Rocketmodels
            local playercutie = table.firstElement(stack:current().engine:getEntityList("IsPlayer"))
            if playercutie:get("ItemComponent").counttimer < 0 then
                local rocket = RocketModel(playercutie:get("PositionComponent").x, playercutie:get("PositionComponent").y, love.mouse.getPosition())
                rocket:get("PhysicsComponent").fixture:setUserData(rocket)
                stack:current().engine:addEntity(rocket)
                playercutie:get("ItemComponent").counttimer = playercutie:get("ItemComponent").timer
            end
        end)
    }
    for i, v in pairs(self.items) do
        self.stats.owned[i] = v.owned
    end
    
    self.waves = {}
        table.insert(self.waves, Wave1())
        table.insert(self.waves, Wave2())
        table.insert(self.waves, Wave3())
        table.insert(self.waves, Wave4())
        table.insert(self.waves, Wave5())
        table.insert(self.waves, Wave6())
        table.insert(self.waves, Wave7())
        table.insert(self.waves, Wave8())
        table.insert(self.waves, Wave9())
        table.insert(self.waves, Wave10())
end
