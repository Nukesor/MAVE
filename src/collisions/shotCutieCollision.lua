ShotCutieCollision = class("ShotCutieCollision")

function ShotCutieCollision:initialize()
    self.component1 = "CutieComponent"
    self.component2 = "IsShot"
end

function ShotCutieCollision:action(entities)
    local cutie = entities.entity1  
    local shot = entities.entity2
    if cutie:get("IsEnemy") then
        cutie:get("LifeComponent").life = cutie:get("LifeComponent").life - shot:get("DamageComponent").damage
    end
    shot:add(DestroyComponent())
end