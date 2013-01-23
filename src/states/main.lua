require("objects/cutie")
require("objects/world")
require("core/ressources")
require("core/gamestate")

mainstate = {}

function mainstate:__init()

	world = love.physics.newWorld()
	cutie1 = class(Cutie)
	cutie2 = class(Cutie)
	walls = class(Walls)
	
	walls:__init()
	cutie1:__init()
	cutie2:__init()

end


function mainstate:update(dt)
	world:update(dt)
	cutie1:update(dt)
	cutie2:update(dt)

end

function mainstate:draw

	love.graphics.draw(ressources.images.arena, 0, 0)
	cutie1:draw()
	cutie2:draw()

		if cutie1.life > 0 and cutie2.life > 0 then

        love.graphics.draw(background, 0, 0)
        love.graphics.draw(cutie1, cutie1.body:getX(), cutie1.body:getY(), 0, 0.3, cutie1.scale)
        love.graphics.draw(cutie2, cutie2.body:getX(), cutie2.body:getY(), 0, 0.3, cutie2.scale)

	        if cutie1.body:getX() < cutie2.body:getX() then

	            cutie1.body:applyForce( 100, 5)
	            cutie2.body:applyForce( -100, 5)
	        end

	        if cutie2.body:getX() < cutie1.body:getX() then

	            cutie2.body:applyForce( 100, 5)
	            cutie1.body:applyForce( -100, 5)
	        end

        if math.abs(cutie1.body:getY() - cutie2.body:getY()) < 35 and math.abs(cutie1.body:getX() - cutie2.body:getX()) < 35 then

            cutie2.body:applyLinearImpulse( math.random(100, 200), math.random(50, 110))
            cutie1.body:applyLinearImpulse( math.random(100, 200), math.random(50, 110))
            cutie2:loselife(math.random(5) * cutie1.cuteness
            cutie1.life = cutie1.life - math.random(5) * cutie2.cuteness
        end

end

function mainstate:destroy()
	cutie1:destroy()
	cutie2:destroy()
	wall:destroy()
	world:destroy()

end

