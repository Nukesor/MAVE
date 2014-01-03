-- Destroys an entity's body and removes it from the engine
function removeEntityWithPhysics(entity)
    stack:current().engine.entities[entity.id]:getComponent("PhysicsComponent").body:destroy()
    stack:current().engine:removeEntity(entity)
end

function equals(a, b)
    local equal = true
    for k, v in pairs(a) do
        if v ~= b[k] then
            equal = false
            break
        end
    end
    return equal
end

function relation()
    local x = set.settings.resolution[1]/1920
    return x
end
