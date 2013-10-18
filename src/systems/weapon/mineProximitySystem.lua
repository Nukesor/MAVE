MineProximitySystem = class("MineProximitySystem", System)

function MineProximitySystem:__init()    end

function MineProximitySystem:update(dt)
    for index, entity in pairs(self.targets) do
        -- Checks if any Enemy is in proximity of the mine
        for index2, enemy in pairs(stack:current().engine:getEntitylist("IsEnemy")) do
            if insideRadius(entity, enemy, entity:getComponent("ProximityExplodeComponent").radius ) then
                stack:current().eventmanager:fireEvent(ExplosionEvent(entity))
                break
            end
        end
    end
end

function MineProximitySystem:getRequiredComponents()
    return {"ProximityExplodeComponent"}
end