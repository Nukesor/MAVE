



Cutie = {} -- Erstellung der Klasse Cutie 1

function Cutie:setup(x,y)
    love.physics.setMeter(64) 
    world = love.physics.newWorld(0, 9.81*64, true)
    self.shape = love.physics.newCircleShape( 20) 
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) 
    self.fixture:setRestitution(1.0) 
    self.life = 100
    self.cuteness = 1
    self.mobbeligkeit = 0

end


function Cutie:update(dt)

    dtotal = dtotal + dt  

    if dtotal >= 1 then
      dtotal = -dtotal
    end

    if self.body:getY() > 480 then
        self.scale = 0.3-((self.body:getY()-480)/300)
    else
        self.scale = 0.3
    end

end

function Cutie:drawn()

love.graphics.draw(resources.images.cutie0, self.body:getX(), self.body:getY(), 0, 0.3, self.scale)

end

function Cutie:position()

    local x = self.body:getX()
    local y = self.body:getY()

    return x, y
end	

function Cutie:shutdown()

    self.fixture:destroy()
    self.body:destroy()

end

function Cutie:loseLife(y)
    
    self.life = self.life - y
end