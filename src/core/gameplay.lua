Gameplay = class("Gameplay")

function Gameplay:__init()
	self.time = 0
	self.highscore = 0
	self.level = 1
	self.kills = 0

	self.gold = 0
	self.items = {
		--String, gekauft, Kosten, image, scalingx, scalingy, function 
		{"Gewehr", true, 100, resources.images.grenade, 0.07, 0.07,
		function()
        -- Erstellt ein neues Shotmodel
        local shot = ShotModel(playercutie:getComponent("PositionComponent").x, (playercutie:getComponent("PositionComponent").y), love.mouse.getPosition())
        shot:getComponent("PhysicsComponent").fixture:setUserData(shot)
        engine:addEntity(shot) 
		end}
		,
		{"Granatwerfer", false, 300, resources.images, grenade, 0,07, 0,07, 
		function()

		end}
		,
		{"Granate", true, 100, resources.images.grenade, 0.07, 0.07, 
		function()
        -- Generates a new Grenademodel
        local grenade = GrenadeModel(playercutie:getComponent("PositionComponent").x, (playercutie:getComponent("PositionComponent").y), love.mouse.getPosition())
        grenade:getComponent("PhysicsComponent").fixture:setUserData(grenade)
        engine:addEntity(grenade)
		end}
		,
		{"Mine", true, 100, resources.images.grenade, 0.07, 0.07,
		function()

		end}
		,
		{"Hammer", true, 100, resources.images.grenade, 0.07, 0.07, 
		function()

		end}
	}
end



--[[ Was muss die Itemlist alles beinhalten 

Potentiell eine eigene Klasse erstellen?? Externe Datenbank zu op? Upgrade Table, oder feste Werte? Tendiere zu  festen Werten. ist meiner meinung nach wesentlich angenehmer. 

Die jeweilige Erstellungsfunktion
Das jeweilige Bild mit passendem Scaling
Daten, ob das item bereits gekauft wurde, oder ob es noch zum verkauf aussteht. 
Kosten
Menuimage
Identifier String

Itemdaten:
	Anzahl
	Schaden
	Maximale Kapazitaet?s

--]]