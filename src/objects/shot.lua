require("core/helper")

Shot = class("Shot")

function Shot:__init(x, y, xt, yt)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape(3) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 0) 
    self.fixture:setRestitution(1)
    self.particles = Particles()
    self.fixture:setUserData("Shot")
    self.akat = xt - x
    self.gkat = yt - y
    self.hypo = math.sqrt(math.pow(self.gkat, 2)+math.pow(self.akat, 2))
    self.sin = self.gkat/self.hypo
    self.cos = self.akat/self.hypo
    self.body:setLinearVelocity(3000*self.sin, 3000*self.cos)
    self.body:setMass(0)
end