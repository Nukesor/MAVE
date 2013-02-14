require("core/helper")
require("objects/particles")

Cutie = class("Cutie")

function Cutie:__init(xs,ys, image)
    self.body = love.physics.newBody(world, xpos, y, "dynamic")
    self.shape = love.physics.newCircleShape(5) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.fixture:setRestitution(1) 
    self.fixture:setUserData(self)
    self.particles = Particles()
    
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


function Cutie:update(dt)
    -- Updatfunktion der Particles
    self.particles.hit:update(dt)
    self.particles.bleeding:update(dt)

    -- Deklaration der lokalen Variablen
    local xpos, ypos =  self:position()
    local xacc, yacc = self.body:getLinearVelocity()
    local playercutiex, playercutiey = playercutie:position()
    local playercutiexv, playercutieyv = playercutie.body:getLinearVelocity()

        -- Wobble des Cuties
        if self.body:getY() > 585 then
            self.scale = 0.1-((self.body:getY()-585)/100)
        else
            self.scale = 0.1
        end

        -- Particle effects des Cuties
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

        -- Geschwindigkeitsbegrenzung für Cuties
        if yacc > 800 then
            self.body:setLinearVelocity(xacc, 800)
            yacc = 800
        elseif yacc < -200 then
            self.body:setLinearVelocity(xacc, -200)
            yacc = -200
        end
        if xacc > 500 then
            self.body:setLinearVelocity(500, yacc)
            xacc = 500
        elseif xacc < -500 then
            self.body:setLinearVelocity(-500, yacc)
            xacc = 500
        end

        -- momentanes Pathfinding des Gegners
        if xpos >= 500 and (xpos-playercutiex) > 500 then
            self.body:applyLinearImpulse( 0.5*main.worldspeed, 0)
        elseif playercutiex < xpos then
            self.body:applyLinearImpulse( -0.5*main.worldspeed, 0)
        elseif xpos <= 500 and (playercutiex-xpos) > 500 then
            self.body:applyLinearImpulse( -0.5*main.worldspeed, 0)
        elseif  xpos < playercutiex then
            self.body:applyLinearImpulse( 0.5*main.worldspeed, 0)
        end
end

function Cutie:draw()

    -- Zeichnen des Cuties und der Particle
    love.graphics.setColorMode("modulate")
    love.graphics.draw(self.particles.hit, 0, 0)
    love.graphics.draw(self.particles.bleeding, 0, 0)
    --love.graphics.setColorMode("replace")
    love.graphics.draw(self.image, self.body:getX(), self.body:getY(), 0, 0.1, self.scale, 140, 140)

    -- Cutie wird bei Seitenwechsel kurzzeitig auf beiden Seiten gezeichnet, sodass der Übergang flüssig von statten geht
    if self.body:getX() < 50 then 
        love.graphics.draw(self.image, self.body:getX()+1000, self.body:getY(), 0, 0.1, self.scale, 140, 140)
    elseif self.body:getX() > 950 then
        love.graphics.draw(self.image, self.body:getX()-1000, self.body:getY(), 0, 0.1, self.scale, 140, 140)
    end
end

function Cutie:loseLife(damage)
    self.life = self.life - damage
end

function Cutie:position()
    local xpos = self.body:getX()
    local ypos = self.body:getY()
    return xpos, ypos
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