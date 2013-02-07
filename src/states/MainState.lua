require("objects/cutie") 
require("objects/walls")
require("core/resources")
require("core/helper")
require("core/state")

MainState = class("MainState", State)

function MainState:__init()
	love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
	cutie1 = Cutie(333, 400)
	cutie2 = Cutie(666, 400)
	walls = Walls()
end

function MainState:update(dt)
	world:update(dt)
    cutie1:update(dt)
    cutie2:update(dt)
end

function MainState:draw()
    love.graphics.draw(resources.images.arena, 0, 0)
    cutie1:draw()
    cutie2:draw()
    
    if cutie1.life > 0 and cutie2.life > 0 then
        if cutie1.body:getX() < cutie2.body:getX() then
            cutie1.body:applyForce( 150, 5)
            cutie2.body:applyForce( -150, 5)
        end

        if cutie2.body:getX() < cutie1.body:getX() then
            cutie2.body:applyForce( 150, 5)
            cutie1.body:applyForce( -150, 5)
        end

        if math.abs(cutie1.body:getY() - cutie2.body:getY()) < 40 and math.abs(cutie1.body:getX() - cutie2.body:getX()) < 40 then
            love.audio.play(resources.music.bounce1)
            cutie2.body:applyLinearImpulse( math.random(100, 200), math.random(50, 70))
            cutie1.body:applyLinearImpulse( math.random(100, 200), math.random(50, 70))
            cutie2:loseLife(math.random(5) * cutie1.cuteness)
            cutie1:loseLife(math.random(5) * cutie2.cuteness)
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

function MainState:shutdown()
	cutie1:shutdown()
	cutie2:shutdown()
	wall:shutdown()
	world:destroy()
end