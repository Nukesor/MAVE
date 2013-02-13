require("core/helper")
require("objects/particles")

Playercutie = class("Playercutie")

function Playercutie:__init(xs,ys, image)
    self.body = love.physics.newBody(world, xpos, ypos, "dynamic")
    self.shape = love.physics.newCircleShape(5) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.fixture:setRestitution(1)
    self.particles = Particles()
    self.fixture:setUserData(self)
    -- Variablen für Jumpbegrenzung
    self.jumpactive = 0
    self.maxyacc = 100
    self.counter = 0

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
end


function Playercutie:update(dt)
    -- Updatfunktion der Particles
    self.particles.hit:update(dt)
    self.particles.bleeding:update(dt)

    -- Deklaration der lokalen Variablen
    local xpos, ypos =  self:position()
    local xacc, yacc = self.body:getLinearVelocity()

        -- Wobble des Playercuties
        if self.body:getY() > 560 then
            self.scale = 0.1-((self.body:getY()-560)/100)
        else
            self.scale = 0.1
        end

        -- Particle effects des Playercuties
        if self.life < self.lifebefore then
            self.particles.hit:setPosition(self:position())
            self.particles.hit:start()
        end
        if self.life < 100 then
            self.particles.bleeding:setPosition(self:position())
            self.particles.bleeding:start()
        end
        self.lifebefore = self.life

        -- Playercutie wird bei Seitenwechsel kurzzeitig auf beiden Seiten gezeichnet, sodass der Übergang flüssig von statten geht
        if self.body:getX() < 50 then 
            love.graphics.draw(self.image, self.body:getX()+1000, self.body:getY(), 0, 0.1, self.scale, 140, 140)
        elseif self.body:getX() > 950 then
            love.graphics.draw(self.image, self.body:getX()-1000, self.body:getY(), 0, 0.1, self.scale, 140, 140)
        end

        --  Implementation einer durchlaufbaren Welt
        local levelchange = self.body:getX()
        if levelchange > 1000 then
            self.body:setX(levelchange - 1000)
        elseif levelchange < 0 then 
            self.body:setX(1000 + levelchange)
        end

        -- Begrenzung der Hüpfhöhe des Playercuties, außer bei Jumps
        if self.yacc then 
            if self.yacc > 0 then
                self.jumpactive = 0
            end 
        end
        if self.jumpactive == 1 then
            self.maxyacc = -200
        elseif self.jumbactive == 0 then
            if self.counter > 0 then
                self.maxyacc = -100 - 100 * self.counter
                self.counter = self.counter - dt
            elseif self.counter < 0 then
                self.counter = 0
                self.maxyacc = -100
            end 
        end

        -- Geschwindigkeitsbegrenzung für Playercutie
        if yacc > 500 then
            self.body:setLinearVelocity(xacc, 500)
            yacc = self.maxyacc
        elseif yacc < self.maxyacc then
            self.body:setLinearVelocity(xacc, self.maxyacc)
        end
        if xacc > 500 then
            self.body:setLinearVelocity(500, yacc)
        elseif xacc < -500 then
            self.body:setLinearVelocity(-500, yacc)        
        end

end

function Playercutie:draw()
    love.graphics.draw(self.particles.hit, 0, 0)
    love.graphics.draw(self.particles.bleeding, 0, 0)
    love.graphics.draw(self.image, self.body:getX(), self.body:getY(), 0, 0.1, self.scale, 140, 140)
end

function Playercutie:loseLife(damage)
    self.life = self.life - damage
end

function Playercutie:position()
    local xpos = self.body:getX()
    local ypos = self.body:getY()
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
    self.fixture:destroy()
    self.body:destroy()
end
