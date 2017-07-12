CutieDeleteSystem = class("CutieDeleteSystem", System)

function CutieDeleteSystem:update()
    for index, entity in pairs(self.targets) do
        -- If EnemyCuties health falls below 0 it gets deleted. Blood is added to gameplay.blood
        if entity:get("LifeComponent").life <= 0 then
            gameplay.stats["blood"] = gameplay.stats["blood"] + entity:get("BloodComponent").blood
            gameplay.stats["kills"] = gameplay.stats["kills"] + 1

            local bloodup = Entity()
            bloodup:add(BloodUpComponent(entity:get("BloodComponent").blood))
            bloodup:add(PositionComponent(entity:get("PositionComponent").x, entity:get("PositionComponent").y))
            bloodup:add(TimerComponent(1.5))
            stack:current().engine:addEntity(bloodup)
            entity:add(DestroyComponent())


            local part = Entity()
            part:add(ParticleTimerComponent(0.6, 0.6))
            part:add(ParticleComponent(resources.images.particle1, 400))

            local particle = part:get("ParticleComponent").particle
            particle:setEmissionRate(300)
            particle:setSpeed(40, 20)
            particle:setSizes(0.3*relation(), 0.4*relation())
            particle:setColors(255, 0, 0, 255, 200, 0, 0, 0)
            particle:setPosition(entity:get("PositionComponent").x, entity:get("PositionComponent").y)
            particle:setEmitterLifetime(0.1) -- Zeit die der Partikelstrahl anhält
            particle:setParticleLifetime(0.5, 0.8) -- setzt Lebenszeit in min-max
            particle:setOffset(0, 0) -- Punkt um den der Partikel rotiert
            particle:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
            particle:setDirection(0)
            particle:setSpread(360)
            particle:setRadialAcceleration(100*relation(), 100*relation())
            particle:setLinearAcceleration(300, 300)
            particle:setAreaSpread( "normal", 5*relation(), 5*relation() )
            part:get("ParticleComponent").particle:start()

            stack:current().engine:addEntity(part)

        end
    end
end

function CutieDeleteSystem:requires()
    return {"IsEnemy"}
end
