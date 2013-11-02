ShotCutieCollision = class("ShotCutieCollision")

function ShotCutieCollision:__init()
    self.component1 = "CutieComponent"
    self.component2 = "IsShot"
end

function ShotCutieCollision:action(entities)
    local cutie = entities.entity1  
    local shot = entities.entity2
    cutie:getComponent("LifeComponent").life = cutie:getComponent("LifeComponent").life - shot:getComponent("DamageComponent").damage
    shot:addComponent(DestroyComponent())
    stack:current().engine:componentAdded(shot, {"DestroyComponent"})
end