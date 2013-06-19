ParticleComponent = class("ParticleComponent")

function ParticleComponent:__init(image, maxparticles, rate, startspeed, endspeed, startsize, endsize, 
                                    r, g, b, alpha1, r2, g2, b2, alpha2,
                                    x, y, lifetime, minpartlife, maxpartlife, minrota, maxrota,
                                     direction, spread, minradacc, maxradacc )

    self.hit = love.graphics.newParticleSystem(image, maxparticles)
    self.hit:setEmissionRate(rate)
    self.hit:setSpeed(startspeed, endspeed)
    self.hit:setColors(r, g, b, alpha1, r2, g2, b2, alpha2)
    self.hit:setSizes(startsize, endsize)
    self.hit:setPosition(x,y)
    self.hit:setLifetime(lifetime) -- Zeit die der Partikelstrahl anhält
    self.hit:setParticleLife( minpartlife, maxpartlife ) -- setzt Lebenszeit in min-max
    -- self.hit:setOffset(x, y) Punkt um den der Partikel rotiert
    self.hit:setRotation(minrota, maxrota) -- Der Rotationswert des Partikels bei seiner Erstellung
    self.hit:setRadialAcceleration(minradacc, maxradacc)
    self.hit:setDirection(direction)
    self.hit:setSpread(spread)
    self.hit:stop()
end