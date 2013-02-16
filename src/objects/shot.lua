require("core/helper")

Shot = class("Shot")

function Shot:__init(x, y, xt, yt)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape(3) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 0) 
    self.fixture:setRestitution(1)
    self.particles = Particles()
    self.fixture:setUserData(self)
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
    self.body:setMass(0)
end

function Shot:update(dt)
    -- Implementation einer durchlaufbaren Welt
    if self.body then
        local levelchange = self.body:getX()
        if levelchange > 1000 then
            self.body:setX(levelchange - 1000)
        elseif levelchange < 0 then 
            self.body:setX(1000 + levelchange)
        end
        self.body:setLinearVelocity((800*self.sin), (800*self.cos))
    end
end

function Shot:shutdown()
    self.fixture:destroy()
    self.body:destroy()
    self.body = nil
    self.fixture = nil
end