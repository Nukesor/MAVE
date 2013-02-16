Entity = class("Entity")

self.components = {}

function Entity:addComponent(component)
    self.components[component.__name] = component
end

function Entity:removeComponent(component)
    if self.components[component] then
        table.remove(self.components, component)
    end
end

function Entity:getComponent(name)
    return self.components[name]
end