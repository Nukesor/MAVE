require("core/helper")

function DestroyBody(entity)
	local physic = entity:getComponent("PhysicsComponent")
	print(entity)
	print(entity.components)
	print(entity:getComponent("PhysicsComponent"))
	print(entity:getComponent("PhysicsComponent").shape)
	physic.body:destroy()
	engine:removeEntity(entity)
end