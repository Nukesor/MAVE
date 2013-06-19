BodyDestroySystem = class("BodyDestroySystem", System)

function BodyDestroySystem:update()
	for index, entity in pairs(self.targets) do
			DestroyBody(entity)
	end
end

function BodyDestroySystem:getRequiredComponents()
	return {"DestroyComponent"}
end