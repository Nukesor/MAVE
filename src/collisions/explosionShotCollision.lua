ExplosionShotCollision = class("ExplosionShotCollision")

function ExplosionShotCollision:initialize()
    self.component1 = "ExplosionComponent"
    self.component2 = "IsShot"
end

function ExplosionShotCollision:action(entities)
    local shot = entities.entity2
    local expl = entities.entity1

    stack:current().eventmanager:fireEvent(ExplosionEvent(expl))
    shot:add(DestroyComponent())
end