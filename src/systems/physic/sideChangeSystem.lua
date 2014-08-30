SideChangeSystem = class("SideChangeSystem", System)

function SideChangeSystem:update()
    -- If any entitys position is below 0 or above love.graphics.getWidth() the entitys position will be set to the other site of the screen.
    for key, entity in pairs(self.targets) do
        local body = entity:get("PhysicsComponent").body
        local x = body:getX()
        if x > love.graphics.getWidth() then
            body:setX(x - love.graphics.getWidth())
        elseif x < 0 then 
            body:setX(love.graphics.getWidth() + x)
        end
    end
end

function SideChangeSystem:requires()
    return {"PhysicsComponent"}
end

