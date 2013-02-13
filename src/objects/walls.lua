require("core/helper")

Walls = class("Walls")

function Walls:__init()
	self.ground = {} -- Erstellung des Objekts Boden
        self.ground.body = love.physics.newBody(world, 1000/2, 570)
        self.ground.shape = love.physics.newRectangleShape(1050, 0)
        self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)
        self.ground.fixture:setUserData("ground")

    self.ceiling = {} -- Erstellung des Objekts Decke
        self.ceiling.body = love.physics.newBody(world, 1000/2, -50)
        self.ceiling.shape = love.physics.newRectangleShape(1050, 0)
        self.ceiling.fixture = love.physics.newFixture(self.ceiling.body, self.ceiling.shape)
        self.ceiling.fixture:setUserData("ceiling")

  --[[]  self.leftside = {} -- Erstellung des Objekts Rechte Seite
        self.leftside.body = love.physics.newBody(world, 1000, 0)
        self.leftside.shape = love.physics.newRectangleShape(0, 1250)
        self.leftside.fixture = love.physics.newFixture(self.leftside.body, self.leftside.shape)
        self.leftside.fixture:setUserData("leftside")

    self.rightside = {} --Erstellung des Objekts Linke Seite
        self.rightside.body = love.physics.newBody(world, 0, 0)
        self.rightside.shape = love.physics.newRectangleShape(0, 1250)
        self.rightside.fixture = love.physics.newFixture(self.rightside.body, self.rightside.shape)
        self.rightside.fixture:setUserData("rightside")--]]
end

function Walls:shutdown()
    self.ground.fixture:destroy()
    self.ceiling.fixture:destroy()
    self.leftside.fixture:destroy()
    self.rightside.fixture:destroy()
    
    self.ground.body:destroy()
    self.ceiling.body:destroy()
    self.leftside.body:destroy()
    self.rightside.body:destroy()
end