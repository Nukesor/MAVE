WobbleSystem = class("WobbleSystem", System)

function WobbleSystem:__init()
    self.__super.__init(self)
    engine:addListener("BeginContact", self)
end

function WobbleSystem:update() 
    for key, entity in pairs(self.targets) do
        local drawable = entity:getComponent("DrawableComponent")
        local wobbly = entity:getComponent("WobblyComponent")
        if drawable.sy < wobbly.default then
            drawable.sy = drawable.sy + (wobbly.default / 70)
        end
    end
end

function WobbleSystem:fireEvent(event)
    local entityA = event.a:getUserData()
    local entityB = event.b:getUserData()
    local physicsA = entityA:getComponent("PhysicsComponent")
    local physicsB = entityB:getComponent("PhysicsComponent")

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

function WobbleSystem:getRequiredComponents()
    return {"DrawableComponent", "WobblyComponent"}
end

function WobbleSystem:setNewSy(entity, speed)
    if not speed and entity:getComponent("PhysicsComponent") then
        speed = distanceBetween({0, 0}, {entity:getComponent("PhysicsComponent").body:getLinearVelocity()})
    end
    
    if entity and entity:getComponent("DrawableComponent") and entity:getComponent("WobblyComponent") then
        local drawable = entity:getComponent("DrawableComponent")
        local wobbly = entity:getComponent("WobblyComponent")
        local maxSpeed = 1000
        drawable.sy = wobbly.default - (wobbly.default / 4) * (speed / maxSpeed)
        if speed > 1000 then
        end
    end
end