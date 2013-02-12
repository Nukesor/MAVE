require("core/helper")
require("objects/particles")

Cutie = class("Cutie")

function Cutie:__init(x,y, image)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape(20) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.fixture:setRestitution(1) 
    self.scale= 0.3
    self.startx = x
    self.starty = y

    self.image = image
    self.level = 0
    self.life = 100
    self.cuteness = 0
    self.mobbelity = 0
    self.lifebefore = 100
    self.particles = Particles()
end


function Cutie:update(dt)
    if self.body:getY() > 480 then
        self.scale = 0.3-((self.body:getY()-480)/300)
    else
        self.scale = 0.3
    end
    if self.life < self.lifebefore then
        self.particles.hit:setPosition(self:position())
        self.particles.hit:start()
    end
    if self.life < 100 then
        self.particles.bleeding:setPosition(self:position())
        self.particles.bleeding:start()
    end
    self.lifebefore = self.life
    self.particles.hit:update(dt)
    self.particles.bleeding:update(dt)
end

function Cutie:draw()
    love.graphics.draw(self.particles.hit, 0, 0)
    love.graphics.draw(self.particles.bleeding, 0, 0)
    love.graphics.draw(self.image, self.body:getX(), self.body:getY(), 0, 0.3, self.scale, 140, 140)
end

function Cutie:position()
    local x = self.body:getX()
    local y = self.body:getY()
    return x, y
end	

function Cutie:shutdown()
    self.fixture:destroy()
    self.body:destroy()
end

function Cutie:loseLife(y)
    self.life = self.life - y
end

function Cutie:reset()
    self.life = 100
    self.mobbelity = 0
    self.cuteness = 0
    self.body:setX(self.startx)
    self.body:setY(self.starty)
    self.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
end

function Cutie:restart()
    self.life = 100 + 10*self.mobbelity
    self.body:setX(self.startx)
    self.body:setY(self.starty)
    self.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
end