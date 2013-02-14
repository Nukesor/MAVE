require("core/helper")

Wall = class("Wall")

function Wall:__init(world, x, y, xl, yl, data, type)
	self.ground = {} -- Erstellung des Objekts Boden
        self.body = love.physics.newBody(world, x, y, type)
        self.shape = love.physics.newRectangleShape(xl, yl)
        self.fixture = love.physics.newFixture(self.body, self.shape)
        if data then
            self.fixture:setUserData(self)
        end
end

function Wall:shutdown()
    self.fixture:destroy()
    self.ground.body:destroy()
end