ShotWallCollision = class("ShotWallCollision")

function ShotWallCollision:__init()
    self.component1 = "DrawablePolygonComponent"
    self.component2 = "IsShot"
end

function ShotWallCollision:action(entities)
    local wall = entities.entity1   
    local shot = entities.entity2
    shot:add(DestroyComponent())
end

