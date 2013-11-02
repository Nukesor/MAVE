RocketCollision = class("RocketCollision")

function RocketCollision:__init()
    self.component1 = "Everything"
    self.component2 = "IsRocket"
end

function RocketCollision:action(entities)
    local rocket = entities.entity1   
    local entity2 = entities.entity2
    stack:current().eventmanager:fireEvent(ExplosionEvent(rocket))
end