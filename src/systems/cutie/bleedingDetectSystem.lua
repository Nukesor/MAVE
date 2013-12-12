BleedingDetectSystem = class("BleedingDetectSystem", System)

function BleedingDetectSystem:update(dt)
    for index, enemy in pairs(self.targets) do
        -- Checks if life is below 1/4 of full health and adds a particleComponent for bleeding animation.
        if (enemy:getComponent("LifeComponent").life/enemy:getComponent("LifeComponent").maxlife) <= 0.25 then
            if not enemy:getComponent("ParticleComponent") then
                enemy:addComponent(ParticleComponent(resources.images.blood1, 200))
                local particle = enemy:getComponent("ParticleComponent").particle
                particle:setEmissionRate(30)
                particle:setSpeed(20, 10)
                particle:setSizes(0.3, 0.2)
                particle:setColors(255, 0, 0, 255, 200, 0, 0, 255)
                particle:setPosition(enemy:getComponent("PositionComponent").x, enemy:getComponent("PositionComponent").y)
                particle:setLifetime(-1) -- Zeit die der Partikelstrahl anhält
                particle:setParticleLife(0.4, 0.5) -- setzt Lebenszeit in min-max
                -- particle:setOffset(x, y) Punkt um den der Partikel rotiert
                particle:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
                particle:setDirection(0)
                particle:setSpread(0)
                particle:setRadialAcceleration(50, 100)
                enemy:getComponent("ParticleComponent").particle:start()
            end
        end
    end
end

function BleedingDetectSystem:getRequiredComponents()
    return{"CutieComponent", "LifeComponent"}
end