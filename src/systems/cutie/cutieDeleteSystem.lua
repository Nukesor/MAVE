require("core/helper")
require("core/system")

CutieDeleteSystem = class("CutieDeleteSystem", System)

function CutieDeleteSystem:update()
    for index, entity in pairs(self.targets) do
        if entity:getComponent("LifeComponent").life <= 0 then
            DestroyBody(entity)
        end
    end
end

function CutieDeleteSystem:getRequiredComponents()
    return {"IsEnemy"}
end