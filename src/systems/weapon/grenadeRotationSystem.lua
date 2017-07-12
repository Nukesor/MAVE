GrenadeRotationSystem = class("GrenadeRotationSystem", System)

-- Rotates the grenade depending on dt

function GrenadeRotationSystem:update(dt)
    for index, value in pairs(self.targets) do
        local drawable = value:get("DrawableComponent")
        local physic = value:get("PhysicsComponent")
        local x, y = physic.body:getLinearVelocity()

        -- Rotates the image in direction of movement  .. ?? Horrible english skills // totally correct :D
        if x > 0 then
            drawable.r = drawable.r + dt*4*math.abs(x+y)/35
        elseif x < 0 then
            drawable.r = drawable.r - dt*4*math.abs(x+y)/35
        end

        -- Resets the rotation rad, if higher than 2*pi
        if (drawable.r > math.pi*2) or (drawable.r < -math.pi*2) then
            drawable.r = 0
        end
        --]]
    end
end

function GrenadeRotationSystem:requires()
    return {"IsGrenade"}
end
