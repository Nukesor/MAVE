ExplosionComponent = class("ExplosionComponent")

function ExplosionComponent:__init(damage, radius)
    self.damage = damage
    self.radius = radius * relation()
end