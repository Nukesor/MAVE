require("core/helper")

Entity = class("Entity")

function Entity:__init()
    self.components = {}
end

function Entity:addComponent(component)
    self.components[component.__name] = component
    engine:refreshEntity(self)
end

function Entity:removeComponent(name)
    if self.components[name] then
        self.components[name] = nil
        print("removed " .. name)
    end
    engine:refreshEntity(self)
end

function Entity:getComponent(name)
    return self.components[name]
end
