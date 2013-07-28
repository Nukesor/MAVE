ExplosionSystem = class("ExplosionSystem", System)

-- Lets explodable things with a timer explode.
function ExplosionSystem:update(dt)
	for index, value in pairs(self.targets) do
		value.components.TimerComponent.time = value.components.TimerComponent.time - dt
		if value.components.TimerComponent.time < 0 then
			stack:current().engine:fireEvent(ExplosionEvent(value))
		end
	end
end

function ExplosionSystem:getRequiredComponents()
	return {"TimerComponent", "ExplosionComponent"}
end