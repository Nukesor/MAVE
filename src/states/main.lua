require("objects/cutie") 
require("objects/walls")
require("core/resources")

MainState = {}

function MainState:setup()

	world = love.physics.newWorld()
	cutie1 = class(Cutie)
	cutie2 = class(Cutie)
	walls = class(Walls)
	
	walls:setup()
	cutie1:setup(333, 400)
	cutie2:setup(666, 400)

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

    love.graphics.draw(background, 0, 0)
    
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
            cutie2:loselife(math.random(5) * cutie1.cuteness)
            cutie1:loselife(math.random(5) * cutie2.cuteness)
        end
    end    
end

function MainState:shutdown()
	
	cutie1:shutdown()
	cutie2:shutdown()
	wall:shutdown()
	world:destroy()

end