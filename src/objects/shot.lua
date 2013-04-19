require("core/helper")

Shot = class("Shot")

function Shot:__init(x, y, xt, yt, entity)
    self.entity = entity
    local body = love.physics.newBody(world, x, y, "dynamic")
    body:setMass(0)
    local shape = love.physics.newCircleShape(3) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
    entity:addComponent(Physics(body, fixture, shape ))
    entity:addComponent()
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape(3) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 0)

    self.particles = Particles()
    self.fixture:setUserData({self, entity})
    if math.abs(xt-x) < 500 then
        self.akat = xt - x
        self.gkat = yt - y
    elseif ((xt - x) > 500) then
        self.akat = -(x - xt + 1000)
        self.gkat = yt - y
    elseif ((xt - x) < -500) then
        self.akat = xt - x + 1000
        self.gkat = yt - y
    end
    self.hypo = math.sqrt(math.pow(self.gkat, 2)+math.pow(self.akat, 2))
    self.cos = self.gkat/self.hypo
    self.sin = self.akat/self.hypo
    self.body:setLinearVelocity((800*self.sin), (800*self.cos))
end

function Shot:shutdown()
    engine:removeEntity(self.entity)
    self.fixture:destroy()
    self.body:destroy()
    self.body = nil
    self.fixture = nil
end