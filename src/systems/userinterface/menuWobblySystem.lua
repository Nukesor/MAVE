MenuWobblySystem = class("MenuWobblySystem", System)

function MenuWobblySystem:update(dt)
    for index, value in pairs(self.targets) do
        local component = value:getComponent("MenuWobblyComponent")
        component.pi = component.pi + dt*2
        if component.pi >= math.pi*2 then
            component.pi = 0
        end
        component.scale = math.sin(component.pi)*0.1+1
    end
end

function MenuWobblySystem:getRequiredComponents()
    return {"MenuWobblyComponent"}
end