CutieModel = class("CutieModel", Entity)

function CutieModel:__init(xs, ys, image, life)

    local body = love.physics.newBody(world, xs, ys, "dynamic")
    local shape = love.physics.newCircleShape(9)
    local fixture = love.physics.newFixture(body, shape, 1) 
    fixture:setUserData(self)
    
    self:addComponent(PhysicsComponent(body, fixture, shape))
    self:addComponent(PositionComponent(xs, ys))
    self:addComponent(DrawableComponent(image, 0, 0.1, 0.1, 140, 140))
    self:addComponent(LevelComponent(0))
    self:addComponent(LifeComponent(life))
    self:addComponent(ZIndex(2))
    self:addComponent(CutieComponent(0, 0, 1))
    self:addComponent(WobblyComponent(0.1))
    self:addComponent(ItemComponent(nil))
    body:setMass(0.0192)

end