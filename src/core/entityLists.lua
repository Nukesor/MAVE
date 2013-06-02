require("core/helper")

EntityLists = class("Entitylists")

function EntityLists:__init()
	self.IsEnemy = {}
	self.IsShot = {}
end

function EntityLists:addEntity(entity)
	for index, component in pairs(entity.components) do
		if self[component.__name] then
			table.insert(self.IsEnemy, entity)
		end
	end
end

function EntityLists:getGroup(string)
	if self[string] then
		return self[string]
	end
end

function EntityLists:removeEntity(entity)
	for index, component in pairs(entity.components) do
		if self[component.__name] then
			table.remove(self.IsEnemy, entity)
		end
	end
end