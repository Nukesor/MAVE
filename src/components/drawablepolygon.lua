require("core/helper")

DrawablePolygon = class("DrawablePolygon")

function DrawablePolygon:__init(wold, x, y, l, h, type, entity)
    self.body = love.physics.newBody(world, x, y, type)
    self.shape = love.physics.newRectangleShape(l, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
   	self.fixture:setUserData({self, entity})
end