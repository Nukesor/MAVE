



Cutie = {} -- Erstellung der Klasse Cutie 1

function Cutie:__init(x,y)

    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newCircleShape( 20) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.fixture:setRestitution(1.0) 
    self.life = 100
    self.cuteness = 1
    self.mobbeligkeit = 0

end


function love.update(dt)


end

function Cutie:drawn()

love.graphics.draw(ressources.images.cutie0, self.body:getX(), self.body:getY() )

end

function Cutie:position()

    local x = self.body:getX()
    local y = self.body:getY()

    return x, y
end	