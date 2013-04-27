require("core/helper")

function DestroyBody(entity)
	local physic = entity:getComponent("PhysicsComponent")
	physic.body:destroy()
	engine:removeEntity(entity)
end