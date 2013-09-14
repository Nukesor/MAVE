SideChangeSystem = class("SideChangeSystem", System)

function SideChangeSystem:update()
    -- If any entitys position is below 0 or above 1000 the entitys position will be set to the other site of the screen.
    for key, entity in pairs(self.targets) do
        local body = entity:getComponent("PhysicsComponent").body
        local x = body:getX()
        if x > 1000 then
            body:setX(x - 1000)
        elseif x < 0 then 
            body:setX(1000 + x)
        end
    end
end

function SideChangeSystem:getRequiredComponents()
    return {"PhysicsComponent"}
end