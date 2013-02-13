require("objects/cutie")
require("objects/player") 
require("objects/walls")
require("core/resources")
require("core/helper")
require("core/state")

MainState = class("MainState", State)

function MainState:__init()
	love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact,endContact)
	playercutie = Playercutie(333, 400, resources.images.cutie1, "playercutie")
	cutie2 = Cutie(666, 400, resources.images.cutie0, "cutie2")
	walls = Walls()
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
    -- Cutienavigation left right
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        playercutie.body:applyLinearImpulse(0.5, 0)
    elseif love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        playercutie.body:applyLinearImpulse(-0.5, 0)
    end

    --Update Functions
	world:update(dt)
    playercutie:update(dt)
    cutie2:update(dt)
end

function MainState:draw()

    -- Deklaration der lokalen Variablen
    local playercutiex, playercutiey = playercutie:position()
    local cutie2x, cutie2y = cutie2:position()
    local playercutiexv, playercutieyv = playercutie.body:getLinearVelocity()
    local cutie2xv, cutie2yv = cutie2.body:getLinearVelocity()

    -- Zeichnen der Grafiken
    if self.shaketimer > 0 then love.graphics.translate(self.shakeX, self.shakeY) end
    love.graphics.draw(resources.images.arena, 0, 0)
    playercutie:draw()
    cutie2:draw()

    -- Zeichnen der Schriftzüge
    love.graphics.print(playercutie.body:getLinearVelocity(), 20, 20,0,1,1)
    love.graphics.print(cutie2.body:getLinearVelocity(), 840, 20,0,1,1)
    love.graphics.print("Your Cutie´s life: " .. playercutie.life, 20, 40, 0, 1, 1)
    love.graphics.print("Enemy Cutie´s life: " .. cutie2.life, 840, 40, 0, 1, 1)

    -- Spielende und Pushen des jeweiligen Gamestates
    if playercutie.life <= 0 and cutie2.life <= 0 then
        stack:push(gameover)
        gameover.mode = 1
    elseif playercutie.life > 0 and cutie2.life <= 0 then
        stack:push(win)
    elseif playercutie.life <= 0 and cutie2.life > 0 then
        stack:push(gameover)
        gameover.mode = 2
    end
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

    -- Cutie Jump
    elseif key == "s" or key == "down" then
        playercutie.body:applyLinearImpulse(0,1)
    elseif key == "w" or key == "up" then
        playercutie.jumpactive = 1
        playercutie.counter = 1
        playercutie.body:applyLinearImpulse(0, -5)
    end
end

-- Collision function
function beginContact(a, b, coll)
    local aa = a:getUserData()
    local bb = b:getUserData()
    if (aa == "playercutie" or aa == "cutie2") and (bb == "playercutie" or bb == "cutie2") then
        love.audio.play(resources.sounds.bounce1)

        -- Schadensmodell
        if math.random(0, 100 + 2*cutie2.cuteness) > 100 then
            playercutie:loseLife(3*math.random(0, 5 + cutie2.cuteness))
        else
            playercutie:loseLife(math.random(0, 5 + cutie2.cuteness))
        end
        if math.random(0, 100 + 2*playercutie.cuteness) > 100 then
            cutie2:loseLife(3*math.random(0, 5 + playercutie.cuteness))
        else
            cutie2:loseLife(math.random(0, 5 + playercutie.cuteness))
        end
    end
end