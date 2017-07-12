local ExplosionComponent = Component.create("ExplosionComponent")

function ExplosionComponent:initialize(damage, radius)
    self.damage = damage
    self.radius = radius * relation()
end

return ExplosionComponent
