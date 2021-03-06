local DrawablePolygonComponent = Component.create("DrawablePolygonComponent")

function DrawablePolygonComponent:initialize(wold, x, y, l, h, type, entity)
    self.body = love.physics.newBody(world, x * relation(), y * relation(), type)
    self.shape = love.physics.newRectangleShape(l * relation(), h * relation())
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(entity)
end

return DrawablePolygonComponent
