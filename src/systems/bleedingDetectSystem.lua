require("core/helper")
require("core/system")

BleedingDetectSystem = class("BleedingDetectSystem", System)

function BleedingDetectSystem:update(dt)
	for index, entity in pairs(self.targets) do
		if entity:getComponent("Life").life <= 20 then
			if not entity:getComponent("ParticleComponent") then
				entity:addComponent(ParticleComponent(resources.images.blood1, 50, 30, 20, 10, 0.3, 0.2, 
                                                255, 0, 0, 255, 200, 0, 0, 255, 
                                                entity:getComponent("Position").x, entity:getComponent("Position").y, -1, 0.4, 0.5, 0, 360, 
                                                0, 0, 50, 100))
				entity:getComponent("ParticleComponent").hit:start()
				print("kick")
			end
			entity:getComponent("ParticleComponent").hit:setPosition(entity:getComponent("Position").x, entity:getComponent("Position").y)
		end
	end
end

function BleedingDetectSystem:getRequiredComponents()
	return{"CutieComponent", "Life"}
end