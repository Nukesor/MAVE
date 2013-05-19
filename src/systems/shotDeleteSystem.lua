require("core/helper")
require("core/system")

ShotDeleteSystem = class("ShotDeleteSystem", System)

function ShotDeleteSystem:update()
	for index, entity in pairs(self.targets) do
		if entity.destroy then
			DestroyBody(entity)
		end
	end
end

function ShotDeleteSystem:getRequiredComponents()
	return {"ShotComponent"}
end