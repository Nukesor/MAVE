

Walls = {}

function Walls:setup()

	Walls.ground = {} -- Erstellung des Objekts Boden
        Walls.ground.body = love.physics.newBody(world, 1000/2, 530)
        Walls.ground.shape = love.physics.newRectangleShape(1050, 0)
        Walls.ground.fixture = love.physics.newFixture(Walls.ground.body, Walls.ground.shape)

    Walls.ceiling = {} -- Erstellung des Objekts Decke
        Walls.ceiling.body = love.physics.newBody(world, 1000/2, -600)
        Walls.ceiling.shape = love.physics.newRectangleShape(1050, 0)
        Walls.ceiling.fixture = love.physics.newFixture(Walls.ceiling.body, Walls.ceiling.shape)

    Walls.sideleft = {} -- Erstellung des Objekts Linke Seite
        Walls.sideleft.body = love.physics.newBody(world, 1000, 0)
        Walls.sideleft.shape = love.physics.newRectangleShape(0, 1250)
        Walls.sideleft.fixture = love.physics.newFixture(Walls.sideleft.body, Walls.sideleft.shape)

    Walls.sideright = {} --Erstellung des Objekts Rechte Seite
        Walls.sideright.body = love.physics.newBody(world, 0, 0)
        Walls.sideright.shape = love.physics.newRectangleShape(0, 1250)
        Walls.sideright.fixture = love.physics.newFixture(Walls.sideright.body, Walls.sideright.shape)

end

function Walls:update(dt)

end

function Walls:shutdown()

    self.ground.fixture:destroy()
    self.ceiling.fixture:destroy()
    self.sideleft.fixture:destroy()
    self.sideright.fixture:destroy()
    
    self.ground.body:destroy()
    self.ceiling.body:destroy()
    self.sideleft.body:destroy()
    self.sideright.body:destroy()

end