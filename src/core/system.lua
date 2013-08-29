System = class("System")

function System:__init()
    -- Liste aller Entities, die die RequiredComponents dieses Systems haben
    self.targets = {}
end

function System:update(dt) end

function System:getRequiredComponents() return {} end

function System:getEntities()
    return self.targets
end


function System:addEntity(entity)
	table.insert(self.targets, entity)
end

function System:removeEntity(entity)
	local index
	for i, value in pairs(self.targets) do
		if value ==  entity then
			index = i
		end
	end
	table.remove(self.targets, index)
end