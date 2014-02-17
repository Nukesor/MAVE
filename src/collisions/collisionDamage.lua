CollisionDamage = class("CollisionDamage")

function CollisionDamage:__init()
    self.component1 = "IsPlayer"
    self.component2 = "IsEnemy"
end

function CollisionDamage:action(entities)
    -- Get some info
    local e1 = entities.entity1   
    local e1XSpeed, e1YSpeed = e1:getComponent("PhysicsComponent").body:getLinearVelocity()

    local e2 = entities.entity2
    local e2XSpeed, e2YSpeed = e2:getComponent("PhysicsComponent").body:getLinearVelocity()

    local difference = distanceBetween({e1XSpeed, e1YSpeed}, {e2XSpeed, e2YSpeed})

    -- Check if there will be no damage dealt
    if (difference < 700) then
        return
    end

    local e1Speed = distanceBetween({0, 0}, {e1XSpeed, e1YSpeed})
    local e2Speed = distanceBetween({0, 0}, {e2XSpeed, e2YSpeed})

    -- Check who will deal the damage
    if e2Speed > e1Speed then
        self:dealDamage(e1, e2)             
    elseif e1Speed > e2Speed then
        self:dealDamage(e2, e1)
    end

    -- Blutpartikel
    blood = Entity()
    blood:addComponent(ParticleComponent(resources.images.particle1, 50))

    local particle = blood:getComponent("ParticleComponent").particle
    particle:setEmissionRate(50)
    particle:setSpeed(40, 20)
    particle:setSizes(0.3*relation(), 0.4*relation())
    particle:setColors(255, 0, 0, 255, 200, 0, 0, 0)
    particle:setPosition(getMid(e1, e2))
    particle:setEmitterLifetime(0.2) -- Zeit die der Partikelstrahl anhält
    particle:setParticleLifetime(0.2, 1) -- setzt Lebenszeit in min-max
    particle:setOffset(0, 0) -- Punkt um den der Partikel rotiert
    particle:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
    particle:setDirection(0)
    particle:setSpread(360)
    particle:setRadialAcceleration(50*relation(), 100*relation())
    particle:setLinearAcceleration(300, 300)
    particle:setAreaSpread( "normal", 5*relation(), 5*relation() )
    particle:start()

    blood:addComponent(ParticleTimerComponent(0.3, 0.5))
    stack:current().engine:addEntity(blood)
end

function CollisionDamage:dealDamage(entity, entity2)
    local entityCuteness = entity2:getComponent("CutieComponent").cuteness
    local damage = math.random(0, 5 + entityCuteness)

    -- Critical particle?
    if math.random(0, 100 + 2*entityCuteness) > 100 then
        damage = damage * 3
        main.shaketimer = 0.25
    end 

    entity:getComponent("LifeComponent").life = entity:getComponent("LifeComponent").life - damage
end