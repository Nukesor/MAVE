ExplosionComponent = class("ExplosionComponent")

function ExplosionComponent:__init(x, y, Damage, Radius)
	self.x = x
	self.y = y
	self.damage = Damage
	self.radius = Radius
end