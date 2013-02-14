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
    self.jumpcounter = 0
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
end


function Playercutie:update(dt)
    -- Updatfunktion der Particles
    self.particles.hit:update(dt)
    self.particles.bleeding:update(dt)

    -- Deklaration der lokalen Variablen
    local xpos, ypos =  self:position()
    local xacc, yacc = self.body:getLinearVelocity()

        -- Cutienavigation left right
        if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
            playercutie.body:applyLinearImpulse(0.5, 0)
        elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
            playercutie.body:applyLinearImpulse(-0.5, 0)
        end

        -- Wobble des Playercuties
        if self.body:getY() > 585 then
            self.scale = 0.1-((self.body:getY()-585)/100)
        else
            self.scale = 0.1
        end

        -- Particle effects des Playercuties
        if self.life < self.lifebefore then
            self.particles.hit:setPosition(self:position())
            self.particles.hit:start()
        end
        if self.life < 20 then
            self.particles.bleeding:setPosition(self:position())
            self.particles.bleeding:start()
        end
        self.lifebefore = self.life

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
            self.maxyacc = -300
        elseif self.jumbactive == 0 then
            if self.jumpcounter > 0 then
                self.maxyacc = -200 - 100 * self.jumpcounter
                self.jumpcounter = self.jumpcounter - dt/2
            elseif self.jumpcounter < 0 then
                self.jumpcounter = 0
                self.maxyacc = -200
            end 
        end

        -- Geschwindigkeitsbegrenzung für Playercutie
        if yacc > 800 then
            self.body:setLinearVelocity(xacc, 800)
            yacc = 800
        elseif yacc < self.maxyacc then
            self.body:setLinearVelocity(xacc, self.maxyacc)
            yacc = self.maxyacc
        end
        if xacc > 500 then
            self.body:setLinearVelocity(500, yacc)
            xacc = 500
        elseif xacc < -500 then
            self.body:setLinearVelocity(-500, yacc)
            xacc = 500
        end

end

function Playercutie:draw()
    love.graphics.setColorMode("modulate")
    love.graphics.draw(self.particles.hit, 0, 0)
    love.graphics.draw(self.particles.bleeding, 0, 0)
    love.graphics.setColorMode("replace")
    love.graphics.draw(self.image, self.body:getX(), self.body:getY(), 0, 0.1, self.scale, 140, 140)
    
    -- Playercutie wird bei Seitenwechsel kurzzeitig auf beiden Seiten gezeichnet, sodass der Übergang flüssig von statten geht
    if self.body:getX() < 50 then 
        love.graphics.draw(self.image, self.body:getX()+1000, self.body:getY(), 0, 0.1, self.scale, 140, 140)
    elseif self.body:getX() > 950 then
        love.graphics.draw(self.image, self.body:getX()-1000, self.body:getY(), 0, 0.1, self.scale, 140, 140)
    end
end

function Playercutie:loseLife(damage)
    self.life = self.life - damage
end

function Playercutie:keypressed(key, u)
    -- Playercutie Jump
    if key == "s" or key == "down" then
        self.body:applyLinearImpulse(0,1)
    elseif key == "w" or key == "up" then
        self.jumpactive = 1
        self.jumpcounter = 1
        if self.jumpcount > 0 then
            self.body:applyLinearImpulse(0, -6)
            self.jumpcount = self.jumpcount - 1
        end
    end
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
