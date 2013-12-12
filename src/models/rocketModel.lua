RocketModel = class("RocketModel", Entity)

function RocketModel:__init(x, y, xt, yt)
    local akat, gkat
    akat = xt - x
    gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local sin = gkat/hypo
    local cos = akat/hypo

    local body = love.physics.newBody(world, x+(80 * cos * relation()), y+(80 * sin * relation()), "dynamic")
    local shape = love.physics.newRectangleShape(50 * relation(), 8 * relation()) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
        
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent(x,y))
    self:addComponent(DrawableComponent(resources.images.rocket, math.atan2(akat, -gkat)-math.pi/2, 0.07, 0.07, 68*relation(), 120*relation()))
    self:addComponent(ZIndex(99))
    self:addComponent(DamageComponent(20))
    self:addComponent(TimerComponent(1.5))
    self:addComponent(IsRocket())
    self:addComponent(ExplosionComponent(80, 150))

    self:addComponent(ParticleComponent(resources.images.particle1, 4000))
    local particle = self:getComponent("ParticleComponent").particle
    particle:setEmissionRate(2000)
    particle:setSpeed(20, 50)
    particle:setSizes(0.5, 0.5)
    particle:setColors(155, 155, 155, 255, 155, 155, 155, 0)
    particle:setPosition(self:getComponent("PositionComponent").x,self:getComponent("PositionComponent").y)
    particle:setLifetime(-1) -- Zeit die der Partikelstrahl anhält
    particle:setParticleLife(0.2, 0.3) -- setzt Lebenszeit in min-max
    -- particle:setOffset(x, y) Punkt um den der Partikel rotiert
    particle:setRotation(0, 360) -- Der Rotationswert des Partikels bei seiner Erstellung
    particle:setDirection(0)
    particle:setSpread(360)
    particle:setRadialAcceleration(50, 100)
    self:getComponent("ParticleComponent").particle:start()

    body:setGravityScale(0.1)
    body:setAngle(math.atan2(akat, -gkat)-math.pi/2)
    body:setLinearVelocity((2000*cos*relation()), (2000*sin*relation()))
end