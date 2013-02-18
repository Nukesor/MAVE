require("core/helper")

Explosive = class("Explosive")

function Explosive:_init(life, image, world, x, y, xl, yl, data, type)
    self.body = love.physics.newBody(world, x, y, type)
    self.shape = love.physics.newRectangleShape(xl, yl)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    if data then
        self.fixture:setUserData(self)
    end
    self.life = life
    self.image = image
end