require("core/helper")
require("core/system")

CollisionDamageSystem = class("CollisionDamageSystem", System)

function CollisionDamageSystem:__init()
    self.component1 = "IsPlayer"
    self.component2 = "IsEnemy"
end

function CollisionDamageSystem.action(entities)
    local entity1 = entities.entity1   
    local entity2 = entities.entity2
    local entity2Cuteness = entity2:getComponent("CutieComponent").cuteness
    local entity1Cuteness = entity1:getComponent("CutieComponent").cuteness

    -- Schadensmodell
    if math.random(0, 100 + 2*entity2Cuteness) > 100 then
        entity1:getComponent("Life").life = entity1:getComponent("Life").life - (3*math.random(0, 5 + entity2Cuteness))
        main.shaketimer = 0.25
    else
        entity1:getComponent("Life").life = entity1:getComponent("Life").life - (math.random(0, 5 + entity2Cuteness))
    end
    if math.random(0, 100 + 2*entity1Cuteness) > 100 then
        entity2:getComponent("Life").life = entity2:getComponent("Life").life - (3*math.random(0, 5 + entity1Cuteness))
        main.shaketimer = 0.25
    else
        entity2:getComponent("Life").life= entity2:getComponent("Life").life -(math.random(0, 5 + entity1Cuteness))
    end
        blood = Entity()
        blood:addComponent(ParticleComponent(resources.images.blood1, 50, 30, 20, 10, 0.3, 0.2, 
                                                255, 0, 0, 255, 200, 0, 0, 255, 
                                                entity1:getComponent("Position").x, entity1:getComponent("Position").y, 0.3, 0.4, 0.5, 0, 360, 
                                                0, 360, 50, 100))
        blood:addComponent(TimeComponent(0.3, 0.5))
        engine:addEntity(blood)
        blood.components.ParticleComponent.hit:start()
end