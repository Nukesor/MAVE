BleedingDetectSystem = class("BleedingDetectSystem", System)

function BleedingDetectSystem:update(dt)
    for index, enemy in pairs(self.targets) do
        -- Checks if life is below 1/4 of full health and adds a particleComponent for bleeding animation.
        if (enemy:get("LifeComponent").life/enemy:get("LifeComponent").maxlife) <= 0.25 then
            if not enemy:get("ParticleComponent") then
                enemy:add(ParticleComponent(resources.images.particle1, 200))
                local particle = enemy:get("ParticleComponent").particle
                particle:setEmissionRate(50)
                particle:setSpeed(40, 20)
                particle:setSizes(0.3*relation(), 0.4*relation())
                particle:setColors(255, 0, 0, 255, 200, 0, 0, 255)
                particle:setPosition(enemy:get("PositionComponent").x, enemy:get("PositionComponent").y)
                particle:setEmitterLifetime(-1) -- Zeit die der Partikelstrahl anhält
                particle:setParticleLifetime(0.2, 1) -- setzt Lebenszeit in min-max
                particle:setOffset(0, 0) -- Punkt um den der Partikel rotiert
                particle:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
                particle:setDirection(0)
                particle:setSpread(360)
                particle:setRadialAcceleration(50*relation(), 100*relation())
                particle:setLinearAcceleration(300, 300)
                particle:setAreaSpread( "normal", 5*relation(), 5*relation() )
                enemy:get("ParticleComponent").particle:start()
            end
        end
    end
end

function BleedingDetectSystem:requires()
    return{"CutieComponent", "LifeComponent"}
end
