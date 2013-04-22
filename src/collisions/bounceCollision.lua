BounceCollision = class("BounceCollision")

function BounceCollision:__init()
    self.component1 = "DrawablePolygonComponent"
    self.component2 = "CutieComponent"
end

function BounceCollision.action(entities)
    local entity1 = entities.entity1   
    local entity2 = entities.entity2

    local cutiexv, cutieyv = entity2:getComponent("PhysicsComponent").body:getLinearVelocity()
    entity2:getComponent("PhysicsComponent").body:setLinearVelocity(cutiexv, -200)
    if entity2:getComponent("IsPlayer") then
    	entity2:getComponent("IsPlayer").jumpcount = 2
    end
end

