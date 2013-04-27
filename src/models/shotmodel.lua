require("core/helper")

ShotModel = class("ShotModel", Entity)

function ShotModel:__init(x, y, xt, yt)
    
    self.__super.__init(self)
    self.damage = 5
    local body = love.physics.newBody(world, x, y, "dynamic")
    local shape = love.physics.newCircleShape(1) 
    local fixture = love.physics.newFixture(body, shape, 0)  
        fixture:setRestitution(1)  
        body:setMass(0)
    self:addComponent(PhysicsComponent(body, fixture, shape ))
    self:addComponent(PositionComponent())
    self:addComponent(DrawableComponent(resources.images.shot, 0, 1, 1, 5, 5))
    self:addComponent(IsShot())
    self:addComponent(ZIndex(99))
    
    local akat, gkat
        akat = xt - x
        gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local cos = gkat/hypo
    local sin = akat/hypo
    body:setLinearVelocity((800 * sin), (800 * cos))
end