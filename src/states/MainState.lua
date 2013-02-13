require("objects/cutie") 
require("objects/walls")
require("core/resources")
require("core/helper")
require("core/state")

MainState = class("MainState", State)

function MainState:__init()
	love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact,endContact)
	cutie1 = Cutie(333, 400, resources.images.cutie1, "cutie1")
	cutie2 = Cutie(666, 400, resources.images.cutie0, "cutie2")
	walls = Walls()
    self.speed = 1;
    self.nextShake = 1
    self.shakeX = 0
    self.shakeY = 0
    self.shaketimer = 0
end

function MainState:load()
   love.graphics.setNewFont()
end

function MainState:update(dt)
    dt = dt*self.speed
    if love.keyboard.isDown(" ") and self.speed > 0.2 then
        self.speed = self.speed -0.03
    elseif not love.keyboard.isDown(" ") and self.speed < 1 then
        self.speed = self.speed + 0.03
    end

    if self.shaketimer > 0 then
        self.nextShake = self.nextShake - (dt*50)
        if self.nextShake < 0 then
            self.nextShake = 1
            self.shakeX = math.random(-10, 10)
            self.shakeY = math.random(-10, 10)
        end
        self.shaketimer = self.shaketimer - dt
    end

	world:update(dt)
    cutie1:update(dt)
    cutie2:update(dt)
end

function MainState:draw()
    love.graphics.translate(self.shakeX, self.shakeY)
    love.graphics.draw(resources.images.arena, 0, 0)
    cutie1:draw()
    cutie2:draw()
    love.graphics.print(cutie2.body:getLinearVelocity(), 840, 20,0,1,1)
    love.graphics.print(cutie1.body:getLinearVelocity(), 20, 20,0,1,1)
    love.graphics.print("Your Cutie´s life: " .. cutie1.life, 20, 40, 0, 1, 1)
    love.graphics.print("Enemy Cutie´s life: " .. cutie2.life, 840, 40, 0, 1, 1)

    local cutie1x, cutie1y = cutie1:position()
    local cutie2x, cutie2y = cutie2:position()
    local cutie1xv, cutie1yv = cutie1.body:getLinearVelocity()
    local cutie2xv, cutie2yv = cutie2.body:getLinearVelocity()

    if cutie1.life > 0 and cutie2.life > 0 then
        if cutie1yv > 2000 then
        cutie1.body:setLinearVelocity(cutie1xv, 2000)
        end
        if cutie1xv > 2500 then
        cutie1.body:setLinearVelocity(2500, cutie1yv)
        end

        if cutie2yv > 2000 then
        cutie2.body:setLinearVelocity(cutie2xv, 2000)
        end
        if cutie2xv > 2500 then
        cutie2.body:setLinearVelocity(2500, cutie2yv)
        end
        
        if cutie1x < cutie2x then
            cutie2.body:applyForce( -150, 5)
        end
        if cutie2x < cutie1x then
            cutie2.body:applyForce( 150, 5)
        end

    elseif cutie1.life <= 0 and cutie2.life <= 0 then
        stack:push(gameover)
        gameover.mode = 1
    elseif cutie1.life > 0 and cutie2.life <= 0 then
        stack:push(win)
    elseif cutie1.life <= 0 and cutie2.life > 0 then
        stack:push(gameover)
        gameover.mode = 2
    end
end

function MainState:reset()
    cutie1:reset()
    cutie2:reset()
end


function MainState:shutdown()
	cutie1:shutdown()
	cutie2:shutdown()
	walls:shutdown()
	world:destroy()
end

function MainState:keypressed(key, u)
    if key == "i" then
        cutie1.life = 0
    elseif key == "o" then
        cutie2.life = 0
    elseif key == "p" then
        cutie1.life = 0
        cutie2.life = 0
    elseif key == "b" then
        self.shaketimer = 1
    elseif key == "s" or key == "down" then
        cutie1.body:applyLinearImpulse(0,200)
    elseif key == "w" or key == "up" then
        cutie1.body:applyLinearImpulse(0,-200)
    elseif key == "d" or key == "right" then
        cutie1.body:applyLinearImpulse(200, 0)
    elseif key == "a" or key == "left" then
        cutie1.body:applyLinearImpulse(-200, 0)
    end
end


function beginContact(a, b, coll)
    local aa = a:getUserData()
    local bb = b:getUserData()
    if (aa == "cutie1" or aa == "cutie2") and (bb == "cutie1" or bb == "cutie2") then
        love.audio.play(resources.sounds.bounce1)
        -- cutie2.body:applyLinearImpulse( math.random(100, 200), math.random(50, 70))
        -- cutie1.body:applyLinearImpulse( math.random(100, 200), math.random(50, 70))            

        if math.random(0, 100 + 2*cutie2.cuteness) > 100 then
            cutie1:loseLife(3*math.random(0, 5 + cutie2.cuteness))
        else
            cutie1:loseLife(math.random(0, 5 + cutie2.cuteness))
        end
        if math.random(0, 100 + 2*cutie1.cuteness) > 100 then
            cutie2:loseLife(3*math.random(0, 5 + cutie1.cuteness))
        else
            cutie2:loseLife(math.random(0, 5 + cutie1.cuteness))
        end
    end
end