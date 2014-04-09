ExplosionEventSystem = class("ExplosionEventSystem")

function ExplosionEventSystem.fireEvent(self, event)
    local entity = event.entity
    local position = entity:get("PositionComponent")
    -- Checks if an enemy is in the explosionradius and adds damage to the Entity.
    for i, enemy in pairs(stack:current().engine:getEntityList("IsEnemy")) do 
        if insideRadius(entity, enemy, entity:get("ExplosionComponent").radius ) then
            enemy:get("LifeComponent").life = enemy:get("LifeComponent").life - entity:get("ExplosionComponent").damage
        end
    end
    -- Removes the exploding Entity
    if entity:get("PhysicsComponent") then
        entity:add(DestroyComponent())
    else
        stack:current().engine:removeEntity(entity)
    end
    -- Creates an entity for Explosionparticles
    explosion = Entity()
    local radius = entity:get("ExplosionComponent").radius
    explosion:add(ParticleTimerComponent(0.6, 0.6))
    explosion:add(ParticleComponent(resources.images.particle1, 400))

    local particle = explosion:get("ParticleComponent").particle
    particle:setEmissionRate(400)
    particle:setSpeed((radius*3-50), (radius*3))
    particle:setSizes(2.5*relation(), 2.8*relation())
    particle:setColors(255, 255, 255, 255,
                        255, 255, 0, 255,
                        200, 0, 0, 255,
                        255, 100, 0, 155)
    particle:setPosition(position.x, position.y)
    particle:setEmitterLifetime(0.6) -- Zeit die der Partikelstrahl anhält
    particle:setParticleLifetime(0.5, 0.6) -- setzt Lebenszeit in min-max
    -- particle:setOffset(x, y) -- Punkt um den der Partikel rotiert
    particle:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
    particle:setDirection(0)
    particle:setSpread(360)
    particle:setRadialAcceleration((radius*-7.5)*relation(), (radius*-7.5)*relation())
    particle:start()

    stack:current().engine:addEntity(explosion)
end