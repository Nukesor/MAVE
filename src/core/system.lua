require("core/helper")

System = class("System")

function System:__init()
    -- Liste aller Entities, die die RequiredComponents dieses Systems haben
    self.targets = {}
end

function System:update() end

function System:getRequiredComponents() end

function System:addEntity(entity)
    table.insert(self.targets, entity)
end