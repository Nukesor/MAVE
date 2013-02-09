require("core/helper")

Cutie = class("Cutie")

function Cutie:__init(x,y, image)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape(20) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.fixture:setRestitution(1) 
    self.life = 100
    self.cuteness = 1
    self.mobbelity = 0
    self.scale= 0.3
    self.level = 0
    self.image = image
end


function Cutie:update(dt)
    if self.body:getY() > 480 then
        self.scale = 0.3-((self.body:getY()-480)/300)
    else
        self.scale = 0.3
    end
end

function Cutie:draw()
    love.graphics.draw(self.image, self.body:getX(), self.body:getY(), 0, 0.3, self.scale)
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