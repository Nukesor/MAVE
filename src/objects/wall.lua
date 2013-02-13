require("core/helper")

Wall = class("Wall")

function Wall:__init(world, x, y, xl, yl)
	self.ground = {} -- Erstellung des Objekts Boden
        self.body = love.physics.newBody(world, x, y, "static")
        self.shape = love.physics.newRectangleShape(xl, yl)
        self.fixture = love.physics.newFixture(self.body, self.shape)
        self.fixture:setUserData(self)

    --[[self.ceiling = {} -- Erstellung des Objekts Decke
        self.ceiling.body = love.physics.newBody(world, 1000/2, -50)
        self.ceiling.shape = love.physics.newRectangleShape(1050, 0)
        self.ceiling.fixture = love.physics.newFixture(self.ceiling.body, self.ceiling.shape)
        self.ceiling.fixture:setUserData("Ceiling")

        self.leftside = {} -- Erstellung des Objekts Rechte Seite
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

function Wall:shutdown()
    self.fixture:destroy()
    self.ground.body:destroy()
end