GrenadeRotationSystem = class("GrenadeRotationSystem", System)


-- Rotates the grenade depending on dt

function GrenadeRotationSystem:update(dt)
	for index, value in pairs(self.targets) do
		local drawable = value:getComponent("DrawableComponent")
		local physic = value:getComponent("PhysicsComponent")
		local x, y = physic.body:getLinearVelocity()
		
		-- Rotates the image in direction of movement  .. ?? Horrible english skills
		if x > 0 then
			drawable.r = drawable.r + dt*4
			drawable.ox = -math.sqrt((drawable.image:getWidth()^2 + drawable.image:getHeight()^2))/2 * math.sin(-drawable.r-0.75*math.pi)
		    drawable.oy = math.sqrt((drawable.image:getWidth()^2 + drawable.image:getHeight()^2))/2 * math.sin(-drawable.r-1.25*math.pi)
		else
			drawable.r = drawable.r - dt*4
			drawable.ox = math.sqrt((drawable.image:getWidth()^2 + drawable.image:getHeight()^2))/2 * math.sin(-drawable.r-0.75*math.pi)
		    drawable.oy = -math.sqrt((drawable.image:getWidth()^2 + drawable.image:getHeight()^2))/2 * math.sin(-drawable.r-1.25*math.pi)
		end
		
		-- Resets the rotation rad, if higher than 2*pi 
		if (drawable.r > math.pi*2) or (drawable.r < -math.pi*2) then
			drawable.r = 0
		end
	end
end

function GrenadeRotationSystem:getRequiredComponents()
	return {"IsGrenade"}
end