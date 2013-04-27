require("core/helper")

ShotCutieCollision = class("ShotCutieCollision")

function ShotCutieCollision:__init()
self.component1 = "IsShot"
self.component2 = "CutieComponent"
end

function ShotCutieCollision.action()
	local entity1 = entities.entity1   
    local entity2 = entities.entity2

    local cutie = entity2:getComponent("CutieComponent")
    cutie.life = cutie.life - entity1.damage
--   	entity2:getComponent("Physics").body:
    engine:removeEntity(entity1)
end

