BounceCollision = class("BounceCollision")

function BounceCollision:__init()
    self.component1 = "DrawablePolygonComponent"
    self.component2 = "CutieComponent"
end

function BounceCollision:action(entities)
    local cutie = entities.entity2

    local cutiexv, cutieyv = cutie:get("PhysicsComponent").body:getLinearVelocity()
    cutie:get("PhysicsComponent").body:setLinearVelocity(cutiexv, -200)
    if cutie:get("IsPlayer") then
        cutie:get("IsPlayer").jumpcount = 2
    end
end

