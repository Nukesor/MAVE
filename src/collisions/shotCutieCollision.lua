require("core/helper")

ShotCutieCollision = class("ShotCutieCollision")

function ShotCutieCollision:__init()
self.component1 = "IsShot"
self.component2 = "CutieComponent"
end

function ShotCutieCollision.action(entities)
	local entity1 = entities.entity1   
    local entity2 = entities.entity2
    local locutie = entity1:getComponent("LifeComponent")
    locutie.life = locutie.life - entity2.damage
    DestroyBody(entity2)
end

