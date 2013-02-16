System = class("System")

function System:__init()
    self.targets = {}
end

function System:update() end

function System:getRequiredComponents() end

function System:addComponent(component)
    table.insert(self.targets, component)
end