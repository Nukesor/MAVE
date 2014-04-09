CutieModel = class("CutieModel", Entity)

function CutieModel:__init(x, y, image, life)

    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newCircleShape(20 * relation())
    local fixture = love.physics.newFixture(body, shape, 1) 
    fixture:setUserData(self)
    fixture:setFilterData(3, 9, 2)

    self:add(PhysicsComponent(body, fixture, shape))
    self:add(PositionComponent(x, y))
    self:add(DrawableComponent(image, 0, 0.2, 0.2, 140, 140))
    self:add(LevelComponent(0))
    self:add(LifeComponent(life))
    self:add(ZIndex(2))
    self:add(CutieComponent(0, 0, 1))
    self:add(WobblyComponent(0.2))
    body:setMass(0.0192)

end
