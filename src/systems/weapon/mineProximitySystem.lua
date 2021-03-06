MineProximitySystem = class("MineProximitySystem", System)

function MineProximitySystem:initialize()    end

function MineProximitySystem:update(dt)
    for index, entity in pairs(self.targets) do
        -- Checks if any Enemy is in proximity of the mine
        for index2, enemy in pairs(stack:current().engine:getEntityList("IsEnemy")) do
            if insideRadius(entity, enemy, entity:get("ProximityExplodeComponent").radius ) then
                stack:current().eventmanager:fireEvent(ExplosionEvent(entity))
                break
            end
        end
    end
end

function MineProximitySystem:requires()
    return {"ProximityExplodeComponent"}
end
