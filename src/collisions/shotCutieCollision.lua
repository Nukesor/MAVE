require("core/helper")

ShotCutieCollision = class("ShotCutieCollision")

function ShotCutieCollision:__init()
    self.component1 = "ShotComponent"
    self.component2 = "CutieComponent"
end

function ShotCutieCollision:action(entities)
	local shotComponent = entities.entity1:getComponent("ShotComponent") 
    local lifeComponent = entities.entity2:getComponent("LifeComponent")
    lifeComponent.life = lifeComponent.life - shotComponent.damage
    entities.entity1.destroy = true
end
