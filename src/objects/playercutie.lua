require("core/helper")
require("objects/particles")
require("objects/shot")

require("components/physics")
require("components/level")

Playercutie = class("Playercutie")

function Playercutie:__init(xs, ys, image, entity)
    self.entity = entity
    self.entity:addComponent(Position(xs, ys))
    self.entity:addComponent(Drawable(image, 0, 0.1, 0.1, 140, 140))
    self.entity:addComponent(ZIndex(100))
    self.entity:addComponent(Level(0))

    self.body = love.physics.newBody(world, xs, ys, "dynamic")
    self.shape = love.physics.newCircleShape(9) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 

    self.entity:addComponent(Physics(self.body, self.fixture, self.shape))

    self.fixture:setRestitution(1)
    self.particles = Particles()
    self.fixture:setUserData({self, self.entity})
    self.body:setMass(0.0192)
    -- Variablen für Jumpbegrenzung
    self.jumpactive = 0
    self.jumpcount = 2

    -- Startwerte
    self.startx = xs
    self.starty = ys
    self.image = image

    -- Attribute
    self.life = 100
    self.cuteness = 0
    self.mobbelity = 0
    self.lifebefore = 100
end


function Playercutie:update(dt)
    -- Updatfunktionen
    self.particles.hit:update(dt)
    self.particles.bleeding:update(dt)

    -- Cutienavigation left right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        playercutie.body:applyLinearImpulse(0.5, 0)
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        playercutie.body:applyLinearImpulse(-0.5, 0)
    end

    -- Particle effects des Playercuties
    if self.life < self.lifebefore then
        self.particles.hit:setPosition(self.body:getX(), self.body:getY())
        self.particles.hit:start()
    end
    if self.life < 20 then
        self.particles.bleeding:setPosition(self.body:getX(), self.body:getY())
        self.particles.bleeding:start()
    end
    self.lifebefore = self.life

    -- Begrenzung der Hüpfhöhe des Playercuties, außer bei Jumps
    if self.yacc then
        if self.yacc > 0 then
            self.jumpactive = 0          
        end 
    end
end

function Playercutie:draw()
    love.graphics.setColor(0, 0, 0)
    love.graphics.draw(self.particles.hit, 0, 0)
    love.graphics.draw(self.particles.bleeding, 0, 0)
    if shot.body then
    love.graphics.circle("fill", shot.body:getX(), shot.body:getY(), shot.shape:getRadius())
    end
    love.graphics.setColor(255, 255, 255)

    -- Playercutie wird bei Seitenwechsel kurzzeitig auf beiden Seiten gezeichnet, sodass der Übergang flüssig von statten geht
    if self.body:getX() < 50 then 
        love.graphics.draw(self.image, self.body:getX()+1000, self.body:getY(), 0, 0.1, self.entity:getComponent("Drawable").sy, 140, 140)
    elseif self.body:getX() > 950 then
        love.graphics.draw(self.image, self.body:getX()-1000, self.body:getY(), 0, 0.1, self.entity:getComponent("Drawable").sy, 140, 140)
    end
end

function Playercutie:loseLife(damage)
    self.life = self.life - damage
end

function Playercutie:keypressed(key, u)
    -- Playercutie Jump
    if key == "s" or key == "down" then
        self.body:applyLinearImpulse(0, 1)
    elseif key == "w" or key == "up" then
        self.jumpactive = 1
        if self.jumpcount > 0 then
            self.body:applyLinearImpulse(0, -6)
            self.jumpcount = self.jumpcount - 1
        end
    end
    if key == "x" then
        if shot.body then
        else
            self.shotEntity = Entity()
            shot = Shot(self.body:getX(), self.body:getY()-20, cutie2.body:getX(), cutie2.body:getY(), self.shotEntity)
            engine:addEntity(self.shotEntity)
        end
    end 
end

function Playercutie:position()
    local xpos = self.entity:getComponent("Position").x
    local ypos = self.entity:getComponent("Position").y
    return xpos, ypos
end 

function Playercutie:reset()
    self.life = 100
    self.mobbelity = 0
    self.cuteness = 0
    self.body:setX(self.startx)
    self.body:setY(self.starty)
    self.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
end

function Playercutie:restart()
    self.life = 100 + 10*self.mobbelity
    self.body:setX(self.startx)
    self.body:setY(self.starty)
    self.body:setLinearVelocity(math.random(-70, 70), math.random(-40, 40))
end

function Playercutie:shutdown()
    self.entity:getComponent("Physics").fixture:destroy()
    self.body:destroy()
end
