MineGroundCollision = class(MineGroundCollision)

function MineGroundCollision:__init()
    self.component1 = "IsMine"
    self.component2 = "DrawablePolygonComponent"
end

function MineGroundCollision:action(entities)
    local mine = entities.entity1

    mine:getComponent("PhysicsComponent").body:setLinearVelocity(0, 0)
end
