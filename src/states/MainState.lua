require("objects/cutie")
require("objects/playercutie") 
require("objects/wall")
require("core/resources")
require("core/helper")
require("core/state")

MainState = class("MainState", State)

function MainState:__init()
	love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact,endContact)
	playercutie = Playercutie(333, 400, resources.images.cutie1)
	cutie2 = Cutie(666, 400, resources.images.cutie0)
	ground = Wall(world, 1000/2, 600, 1050, 10, true, "static")
    ceiling = Wall(world, 1000/2, -50, 1050, 0, false)
    plate1 = Wall(world, 20, 200, 10, 100, true, "static")
    plate2 = Wall(world, 1000/2, 100, 200, 10, true, "static")
    plate3 = Wall(world, 1000/2, 200, 300, 10, true, "static")
    plate4 = Wall(world, 1000/2, 300, 400, 10, true, "static")
    plate5 = Wall(world, 1000/2, 400, 500, 10, true, "static")
    plate6 = Wall(world, 1000/2, 500, 600, 10, true, "static")

    -- Slowmospeed
    self.worldspeed = 1;

    -- Shake Variablen
    self.nextShake = 1
    self.shakeX = 0
    self.shakeY = 0
    self.shaketimer = 0
end

function MainState:load()
   love.graphics.setNewFont()
end

function MainState:update(dt)
    -- Slowmotion
    dt = dt*self.worldspeed
    if love.keyboard.isDown(" ") and self.worldspeed > 0.2 then
        self.worldspeed = self.worldspeed -0.03
    elseif not love.keyboard.isDown(" ") and self.worldspeed < 1 then
        self.worldspeed = self.worldspeed + 0.03
    end

    -- Camerashake
    if self.shaketimer > 0 then
        self.nextShake = self.nextShake - (dt*50)
        if self.nextShake < 0 then
            self.nextShake = 1
            self.shakeX = math.random(-10, 10)
            self.shakeY = math.random(-10, 10)
        end
        self.shaketimer = self.shaketimer - dt
    end

    -- Spiel-Ende und Pushen des jeweiligen Gamestates
    if playercutie.life <= 0 and cutie2.life <= 0 then
        stack:push(gameover)
        gameover.mode = 1
    elseif cutie2.life <= 0 then
        stack:push(win)
    elseif playercutie.life <= 0 then
        stack:push(gameover)
        gameover.mode = 2
    end

    -- Update Functions
    playercutie:update(dt)
    cutie2:update(dt)
	world:update(dt)
end

function MainState:draw()
    
    -- Deklaration der lokalen Variablen
    local playercutiexv, playercutieyv = playercutie.body:getLinearVelocity()
    local cutie2xv, cutie2yv = cutie2.body:getLinearVelocity()

    -- Zeichnen der Grafiken
    love.graphics.setColorMode("replace")
    if self.shaketimer > 0 then love.graphics.translate(self.shakeX, self.shakeY) end
    love.graphics.draw(resources.images.arena, 0, 0)

    -- Cutie Zeichnung und Drawfunktion
    playercutie:draw()
    cutie2:draw()

    -- Zeichnen der Ebenen in Farbe Grau
    love.graphics.setColorMode("modulate")
    love.graphics.setColor(50, 50, 50)
    love.graphics.polygon("fill", plate1.body:getWorldPoints(plate1.shape:getPoints()))
    love.graphics.polygon("fill", plate2.body:getWorldPoints(plate2.shape:getPoints()))
    love.graphics.polygon("fill", plate3.body:getWorldPoints(plate3.shape:getPoints()))
    love.graphics.polygon("fill", plate4.body:getWorldPoints(plate4.shape:getPoints()))
    love.graphics.polygon("fill", plate5.body:getWorldPoints(plate5.shape:getPoints()))
    love.graphics.polygon("fill", plate6.body:getWorldPoints(plate6.shape:getPoints()))
    love.graphics.setColorMode("replace")
    -- Zeichnen der Schriftzüge
    love.graphics.print("X-Vel: " .. string.format("%.2f ",playercutiexv) .. ", Y-Vel: " .. string.format("%.2f ",playercutieyv), 20, 20,0,1,1)
    love.graphics.print("X-Vel: " .. string.format("%.2f ",cutie2xv) .. ", Y-Vel: " .. string.format("%.2f ",cutie2yv), 800, 20,0,1,1)
    love.graphics.print("Your Cutie´s life: " .. playercutie.life, 20, 40, 0, 1, 1)
    love.graphics.print("Enemy Cutie´s life: " .. cutie2.life, 840, 40, 0, 1, 1)
end

function MainState:reset()
    playercutie:reset()
    cutie2:reset()
end


function MainState:shutdown()
	playercutie:shutdown()
	cutie2:shutdown()
	walls:shutdown()
	world:destroy()
end

function MainState:keypressed(key, u)
    if key == "i" then
        playercutie.life = 0
    elseif key == "o" then
        cutie2.life = 0
    elseif key == "p" then
        playercutie.life = 0
        cutie2.life = 0
    elseif key == "b" then
        self.shaketimer = 0.5
    end
    playercutie:keypressed(key, u)
end

function MainState:keyreleased(key, u)
    if key == "w" or key == "up" then
        playercutie.jumpactive = 0
    end
end

--Collision function
function beginContact(a, b, coll)
    local object1 = a:getUserData()
    local object2 = b:getUserData()
    if object1 and object2 then
        if (object1.__name == "Playercutie" or object1.__name == "Cutie") and (object1.__name == "Playercutie" or object1.__name == "Cutie") then
            love.audio.play(resources.sounds.bounce1)

            -- Schadensmodell
            if math.random(0, 100 + 2*object2.cuteness) > 100 then
                object1:loseLife(3*math.random(0, 5 + object2.cuteness))
            else
                object1:loseLife(math.random(0, 5 + object2.cuteness))
            end
            if math.random(0, 100 + 2*object1.cuteness) > 100 then
                object2:loseLife(3*math.random(0, 5 + object1.cuteness))
            else
                object2:loseLife(math.random(0, 5 + object1.cuteness))
            end
        end
        -- Hüpfen der Cuties auf einem bestimmten Level
        if (( object2.__name == "Wall" or object2.__name == "Cutie") and (object1.__name == "Cutie" or object1.__name == "Wall")) then
            if object1.__name == "Cutie" then
                local cutiexv, cutieyv = object1.body:getLinearVelocity()
                object1.body:setLinearVelocity(cutiexv, -200)
            elseif object2.__name == "Cutie" then
                local cutiexv, cutieyv = object2.body:getLinearVelocity()
                object2.body:setLinearVelocity(cutiexv, -200)
            end
        end
        if (object1.__name == "Playercutie" or object1.__name == "Wall" ) and (object2.__name == "Wall" or object2.__name == "Playercutie" ) then
            playercutie.jumpcount = 2
        end
    end
end
