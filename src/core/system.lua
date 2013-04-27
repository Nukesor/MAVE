require("core/helper")

System = class("System")

function System:__init()
    -- Liste aller Entities, die die RequiredComponents dieses Systems haben
    self.targets = {}
end

function System:update(dt) end

function System:getRequiredComponents() end

function System:getEntities()
    return self.targets
end

function System:removeEntity(entity)
    for key, systemEntity in pairs(self.targets) do
        if systemEntity == entity then
            table.remove(self.targets, key)
        end
    end
end

function System:addEntity(entity)
    local flag = false
    for index, value in pairs(self.targets) do
        if value == entity then
            flag = true
            break
        end
    end
    if flag ==  false then
        table.insert(self.targets, entity)
    end
end