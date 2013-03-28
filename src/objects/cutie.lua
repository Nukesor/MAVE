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
    local xpos, ypos =  self:position()
    local xacc, yacc = self.body:getLinearVelocity()
    local playercutiex, playercutiey = playercutie:position()
    local playercutiexv, playercutieyv = playercutie.body:getLinearVelocity()
    local speed = main.worldspeed

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

        if self.yacc then
            if self.yacc > 0 then
                self.jumpactive = 0
            end 
        end
        if self.jumpactive == 1 then
            self.maxyacc = -300
        elseif self.jumbactive == 0 then
            self.maxyacc = -200
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
--[[        if xpos >= 500 and (xpos-playercutiex) > 500 then
            self.body:applyLinearImpulse( 0.5*speed, 0)
        elseif playercutiex < xpos then
            self.body:applyLinearImpulse( -0.5*speed, 0)
        elseif xpos <= 500 and (playercutiex-xpos) > 500 then
            self.body:applyLinearImpulse( -0.5*speed, 0)
        elseif  xpos < playercutiex then
            self.body:applyLinearImpulse( 0.5*speed, 0)
        end --]]

        -- Ki
if ypos <= 579 then
    self.height = 500
    if ypos <= 495 then
        self.height = 400
        if ypos <= 395 then
            self.height = 300
            if ypos <= 295 then
                self.height = 200
                if ypos <= 195 then
                    self.height = 100
                    if ypos <= 95 then
                        self.height = 0
                    end
                end
            end
        end
    end
end


    if playercutiey < self.height then
        if self.check == 0 then
            self.check = 1
            if playercutiex > 500 then
                self.direction = 1
            elseif playercutiey < 500 then
                self.direction = 0
            end
        end

        if  xpos <= (200 + (5-self.height/100)*50) or xpos >= (800 - (5-self.height/100)*50) then
            self.check = 0
            self.body:applyLinearImpulse(0, -6)
            if ypos > 300 then
                if xpos < playercutiex and (playercutiex - xpos) < 500 then
                    self.body:applyLinearImpulse( 0.5*speed, 0)
                elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
                    self.body:applyLinearImpulse( -0.5*speed, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
                    self.body:applyLinearImpulse( -0.5*speed, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
                    self.body:applyLinearImpulse( 0.5*speed, 0)
                end
            else
                if playercutiex > xpos then
                    self.body:applyLinearImpulse( 0.5*speed, 0)
                elseif playercutiex < xpos then
                    self.body:applyLinearImpulse( -0.5*speed, 0)
                end
            end  
        else
            if self.direction == 1 then
                self.body:applyLinearImpulse( 0.5*speed, 0)
            elseif self.direction == 0 then
                self.body:applyLinearImpulse( -0.5*speed, 0)
            end
        end

    elseif playercutiey > (self.height+100) then
        if self.check == 0 then
            self.check = 1
            if playercutiex > 500 then
                self.direction = 1
            elseif playercutiex < 500 then
                self.direction = 0
            end
        end
        if  xpos < (390 - (self.height/100)*50) or xpos > (610 + (self.height/100)*50) then
            self.check = 0
            if ypos > 300 then
                if xpos < playercutiex and (playercutiex - xpos) < 500 then
                    self.body:applyLinearImpulse( 0.5*speed, 0)
                elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
                    self.body:applyLinearImpulse( -0.5*speed, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
                    self.body:applyLinearImpulse( -0.5*speed, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
                    self.body:applyLinearImpulse( 0.5*speed, 0)
                end
            else
                if playercutiex > xpos then
                    self.body:applyLinearImpulse( 0.5*speed, 0)
                elseif playercutiex < xpos then
                    self.body:applyLinearImpulse( -0.5*speed, 0)
                end
            end
        else
            if self.direction == 1 then
                self.body:applyLinearImpulse( 0.5*speed, 0)
            elseif self.direction == 0 then
                self.body:applyLinearImpulse( -0.5*speed, 0)
            end
        end
    else
        self.check = 0
        if ypos > 300 then
            if xpos < playercutiex and (playercutiex - xpos) < 500 then
                self.body:applyLinearImpulse( 0.5*speed, 0)
            elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
                self.body:applyLinearImpulse( -0.5*speed, 0)
            elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
                self.body:applyLinearImpulse( -0.5*speed, 0)
            elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
                self.body:applyLinearImpulse( 0.5*speed, 0)
            end
        else
            if playercutiex > xpos then
                self.body:applyLinearImpulse( 0.5*speed, 0)
            elseif playercutiex < xpos then
                self.body:applyLinearImpulse( -0.5*speed, 0)
            end
        end  
     end
end

function Cutie:draw()

    -- Zeichnen des Cuties und der Particle
    love.graphics.setColor(0, 0, 0)
    love.graphics.draw(self.particles.hit, 0, 0)
    love.graphics.draw(self.particles.bleeding, 0, 0)
    --love.graphics.setColor(255, 255, 255)
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
    print("cutie:loselife called")
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