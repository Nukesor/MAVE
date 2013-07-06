ExplosionShotCollision = class("ExplosionShotCollision")

function ExplosionShotCollision:__init()
    self.component1 = "ExplosionComponent"
    self.component2 = "IsShot"
end

function ExplosionShotCollision:action(entities)
    local shot = entities.entity2
    local expl = entities.entity1

    expl:getComponent("TimerComponent").time = 0
    DestroyBody(shot)
end