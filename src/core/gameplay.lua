require("core/events/buyBoolEvent")

Gameplay = class("Gameplay")

function Gameplay:__init()
	self.time = 0
	self.highscore = 0
	self.level = 1
	self.kills = 0

	self.gold = 100
	self.items = {
		--String, gekauft, Kosten, image, scalingx, scalingy, function 
		{"Gewehr", false, 100, resources.images.grenade, 0.07, 0.07,
		function()
            -- Erstellt ein neues Shotmodel
            local shot = ShotModel(playercutie:getComponent("PositionComponent").x, (playercutie:getComponent("PositionComponent").y), love.mouse.getPosition())
            shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
            stack:current().engine:addEntity(shot) 
		end}
		,
		{"Granatwerfer", false, 300, resources.images, grenade, 0,07, 0,07, 
		function()

		end}
		,
		{"Granate", false, 100, resources.images.grenade, 0.07, 0.07, 
		function()
            -- Generates a new Grenademodel
            local grenade = GrenadeModel(playercutie:getComponent("PositionComponent").x, (playercutie:getComponent("PositionComponent").y), love.mouse.getPosition())
            grenade:getComponent("PhysicsComponent").fixture:setUserData(grenade)
            stack:current().engine:addEntity(grenade)
		end}
		,
		{"Mine", false, 100, resources.images.grenade, 0.07, 0.07,
		function()
		end}
		,
		{"Hammer", false, 100, resources.images.grenade, 0.07, 0.07, 
    	function()
		end}
	}
end