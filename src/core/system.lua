System = class("System")

function System:__init()
    self.targets = {}
end

function System:process() end

function System:addComponent(component)
    table.insert(self.targets, component)
end