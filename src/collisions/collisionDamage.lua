require("core/helper")
require("core/system")

CollisionDamage = class("CollisionDamage")

function CollisionDamage:__init()
    self.component1 = "IsPlayer"
    self.component2 = "IsEnemy"
end

function CollisionDamage.action(entities)
    local entity1 = entities.entity1   
    local entity2 = entities.entity2
    local entity1Cuteness = entity1:getComponent("CutieComponent").cuteness
    local entity2Cuteness = entity2:getComponent("CutieComponent").cuteness

    -- Critical hit
    if math.random(0, 100 + 2*entity2Cuteness) > 100 then
        entity1:getComponent("LifeComponent").life = entity1:getComponent("LifeComponent").life - (3*math.random(0, 5 + entity2Cuteness))
        main.shaketimer = 0.25
    -- Normal hit
    else
        entity1:getComponent("LifeComponent").life = entity1:getComponent("LifeComponent").life - (math.random(0, 5 + entity2Cuteness))
    end
    -- Critical hit
    if math.random(0, 100 + 2*entity1Cuteness) > 100 then
        entity2:getComponent("LifeComponent").life = entity2:getComponent("LifeComponent").life - (3*math.random(0, 5 + entity1Cuteness))
        main.shaketimer = 0.25
    -- Normal hit
    else
        entity2:getComponent("LifeComponent").life= entity2:getComponent("LifeComponent").life -(math.random(0, 5 + entity1Cuteness))
    end

    -- Blutpartikel
    blood = Entity()
    blood:addComponent(ParticleComponent(resources.images.blood1, 50, 30, 20, 10, 0.3, 0.2, 
                                            255, 0, 0, 255, 200, 0, 0, 255, 
                                            entity1:getComponent("PositionComponent").x, entity1:getComponent("PositionComponent").y, 0.3, 0.4, 0.5, 0, 360, 
                                            0, 360, 50, 100))
    blood:addComponent(TimeComponent(0.3, 0.5))
    engine:addEntity(blood)
    blood.components.ParticleComponent.hit:start()
end