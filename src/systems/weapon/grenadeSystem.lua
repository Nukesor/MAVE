GrenadeSystem = class("GrenadeSystem", System)

--ExplosionSystem Rename
function GrenadeSystem:update(dt)
	for index, value in pairs(self.targets) do
		value.components.TimerComponent.time = value.components.TimerComponent.time - dt
		if value.components.TimerComponent.time < 0 then
			engine:fireEvent(ExplosionEvent(value))
		end
	end
end

function GrenadeSystem:getRequiredComponents()
	return {"TimerComponent", "ExplosionComponent"}
end