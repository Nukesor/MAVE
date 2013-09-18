CutieModel = class("CutieModel", Entity)

function CutieModel:__init(x, y, image, life)

    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newCircleShape(20 * relation())
    local fixture = love.physics.newFixture(body, shape, 1) 
    fixture:setUserData(self)
    
    self:addComponent(PhysicsComponent(body, fixture, shape))
    self:addComponent(PositionComponent(x, y))
    self:addComponent(DrawableComponent(image, 0, 0.2*relation(), 0.2*relation(), 140, 140))
    self:addComponent(LevelComponent(0))
    self:addComponent(LifeComponent(life))
    self:addComponent(ZIndex(2))
    self:addComponent(CutieComponent(0, 0, 1))
    self:addComponent(WobblyComponent(0.1))
    body:setMass(0.0192)

end