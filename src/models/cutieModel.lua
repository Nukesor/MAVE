require("core/helper")

CutieModel = class("CutieModel", Entity)

function CutieModel:__init(xs, ys, image)
	
	self.components = {}

    local body = love.physics.newBody(world, xs, ys, "dynamic")
    local shape = love.physics.newCircleShape(9)
    local fixture = love.physics.newFixture(body, shape, 1) 
	
	self:addComponent(Physics(body, fixture, shape))
    self:addComponent(Position(xs, ys))
    self:addComponent(Drawable(image, 0, 0.1, 0.1, 140, 140))
    self:addComponent(ZIndex(100))
    self:addComponent(Level(0))
    self:addComponent(Life(100))
    self:addComponent(CutieComponent(0, 0, 1))
    self:addComponent(Bouncy(0.1))
    body:setMass(0.0192)

end