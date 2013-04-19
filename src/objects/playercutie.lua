require("core/helper")

Playercutie = class("Playercutie")

function Playercutie:__init(xs, ys, image)
    self:createEntity(xs, ys, image)
    self.body = love.physics.newBody(world, xs, ys, "dynamic")
    self.shape = love.physics.newCircleShape(9) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.entity:addComponent(Physics(self.body, self.fixture, self.shape))

    self.fixture:setRestitution(1)
    self.particles = Particles()
    self.fixture:setUserData({self, self.entity})
    self.body:setMass(0.0192)
    

end

function Playercutie:createEntity(xs, ys, image)
    self.entity = Entity()
    self.entity:addComponent(Position(xs, ys))
    self.entity:addComponent(Drawable(image, 0, 0.1, 0.1, 140, 140))
    self.entity:addComponent(ZIndex(100))
    self.entity:addComponent(Level(0))
    self.entity:addComponent(Life(100))
    self.entity:addComponent(CutieComponent(0, 0, 1))
    self.entity:addComponent(Bouncy(0.1))
    self.entity:addComponent(IsPlayer())
end

function Playercutie:update(dt)
    -- Updatfunktionen
    self.particles.hit:update(dt)
    self.particles.bleeding:update(dt)

   

function Playercutie:reset()
    self.entity:getComponent("Life").life = 100
    self.entity:getComponent("CutieComponent").mobbelity = 0
    self.entity:getComponent("CutieComponent").cuteness = 0
    self.body:setX(self.startx)
    self.body:setY(self.starty)
    self.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
end

function Playercutie:restart()
    self.entity:getComponent("Life").life = 100 + 10*self.entity:getComponent("CutieComponent").mobbelity
    self.body:setX(self.startx)
    self.body:setY(self.starty)
    self.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
end

function Playercutie:shutdown()
    self.entity:getComponent("Physics").fixture:destroy()
    self.body:destroy()
end
