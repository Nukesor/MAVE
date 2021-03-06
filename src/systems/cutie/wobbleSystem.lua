WobbleSystem = class("WobbleSystem", System)

function WobbleSystem:update()
    for key, entity in pairs(self.targets) do
        local drawable = entity:get("DrawableComponent")
        local wobbly = entity:get("WobblyComponent")
        if drawable.sy < wobbly.default then
            drawable.sy = (drawable.sy + (wobbly.default/70)*relation())
        end
    end
end

function WobbleSystem.fireEvent(self, event)
    local entityA = event.a:getUserData()
    local entityB = event.b:getUserData()
    local physicsA = entityA:get("PhysicsComponent")
    local physicsB = entityB:get("PhysicsComponent")

    if physicsA and physicsB then
        local speed = distanceBetween({physicsA.body:getLinearVelocity()}, {physicsB.body:getLinearVelocity()})
        self:setNewSy(entityA, speed)
        self:setNewSy(entityB, speed)
    elseif physicsA then
        self:setNewSy(entityA)
    elseif physicsB then
        self:setNewSy(entityB)
    end
end

function WobbleSystem:requires()
    return {"DrawableComponent", "WobblyComponent"}
end

function WobbleSystem:setNewSy(entity, speed)
    if not speed then
        speed = distanceBetween({0, 0}, {entity:get("PhysicsComponent").body:getLinearVelocity()})
    end

    if entity and entity:get("DrawableComponent") and entity:get("WobblyComponent") then
        local drawable = entity:get("DrawableComponent")
        local wobbly = entity:get("WobblyComponent")
        local maxSpeed = 1000
        drawable.sy = wobbly.default - ((wobbly.default/3) * (speed / maxSpeed))
    end
end
