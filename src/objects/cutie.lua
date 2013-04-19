require("core/helper")
require("objects/particles")

Cutie = class("Cutie")

function Cutie:__init(xs,ys, image, entity)
    self.body = love.physics.newBody(world, xs, ys, "dynamic")
    self.shape = love.physics.newCircleShape(9) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.fixture:setRestitution(1) 
    self.fixture:setUserData({self, entity})
    self.particles = Particles()
    self.body:setMass(0.0192)

    self.jumpactive = 0
    self.maxyacc = -200
    self.jumpcount = 2
    
    -- Startwerte
    self.scale= 0.3
    self.startx = xs
    self.starty = ys
    self.image = image

    -- Attribute
    self.level = 0
    self.life = 100
    self.cuteness = 0
    self.mobbelity = 0
    self.lifebefore = 100

    self.check = 0
end


function Cutie:update(dt)
    -- Updatfunktion der Particles
    self.particles.hit:update(dt)
    self.particles.bleeding:update(dt)

    -- Deklaration der lokalen Variablen


       


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

function Cutie:shutdown()
    self.fixture:destroy()
    self.body:destroy()
end