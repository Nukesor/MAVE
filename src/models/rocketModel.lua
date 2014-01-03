RocketModel = class("RocketModel", Entity)

function RocketModel:__init(x, y, xt, yt)
    local sin, cos = getSinCos(x, y, xt, yt)

    local body = love.physics.newBody(world, x+(80 * cos * relation()), y+(80 * sin * relation()), "dynamic")
    local shape = love.physics.newRectangleShape(50 * relation(), 8 * relation()) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
        
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent(x,y))
    self:addComponent(DrawableComponent(resources.images.rocket, getRadian(x, y, xt, yt), 0.07, 0.07, 68*relation(), 120*relation()))
    self:addComponent(ZIndex(99))
    self:addComponent(DamageComponent(20))
    self:addComponent(TimerComponent(1.5))
    self:addComponent(IsRocket())
    self:addComponent(ExplosionComponent(80, 150*relation()))

    self:addComponent(ParticleComponent(resources.images.particle1, 4000))
    local particle = self:getComponent("ParticleComponent").particle
    particle:setEmissionRate(2000)
    particle:setSpeed(50*relation(), 350*relation())
    particle:setSizes(0.5*relation(), 0.5*relation())
    particle:setColors(155, 155, 155, 255, 155, 155, 155, 0)
    particle:setPosition(self:getComponent("PositionComponent").x,self:getComponent("PositionComponent").y)
    particle:setEmitterLifetime(-1) -- Emitter will live forever
    particle:setParticleLifetime(0.4, 0.5)
    particle:setSpread(0.2)
    particle:setDirection(math.pi+getRadian(x, y, xt, yt))
    particle:start()

    body:setGravityScale(0)
    body:setAngle(getRadian(x, y, xt, yt))
    body:setLinearVelocity((1500*cos*relation()), (1500*sin*relation()))
end