require("core/helper")

ShotCutieCollision = class("ShotCutieCollision")

function ShotCutieCollision:__init()
self.component1 = "IsShot"
self.component2 = "CutieComponent"
end

function ShotCutieCollision.action(entities)
	local entity1 = entities.entity1   
    local entity2 = entities.entity2
    entity1:getComponent("LifeComponent").life = entity1:getComponent("LifeComponent").life - entity2.damage
    entity2.destroy = true
end

