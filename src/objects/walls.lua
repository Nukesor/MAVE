require("core/helper")

Walls = class("Walls")

function Walls:__init()
	self.ground = {} -- Erstellung des Objekts Boden
        self.ground.body = love.physics.newBody(world, 1000/2, 570)
        self.ground.shape = love.physics.newRectangleShape(1050, 0)
        self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)

    self.ceiling = {} -- Erstellung des Objekts Decke
        self.ceiling.body = love.physics.newBody(world, 1000/2, -50)
        self.ceiling.shape = love.physics.newRectangleShape(1050, 0)
        self.ceiling.fixture = love.physics.newFixture(self.ceiling.body, self.ceiling.shape)

    self.sideleft = {} -- Erstellung des Objekts Rechte Seite
        self.sideleft.body = love.physics.newBody(world, 1000, 0)
        self.sideleft.shape = love.physics.newRectangleShape(0, 1250)
        self.sideleft.fixture = love.physics.newFixture(self.sideleft.body, self.sideleft.shape)

    self.sideright = {} --Erstellung des Objekts Linke Seite
        self.sideright.body = love.physics.newBody(world, 0, 0)
        self.sideright.shape = love.physics.newRectangleShape(0, 1250)
        self.sideright.fixture = love.physics.newFixture(self.sideright.body, self.sideright.shape)
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