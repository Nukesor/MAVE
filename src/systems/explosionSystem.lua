require("core/helper")
require("core/system")

ExplosionSystem = class("ExplosionSystem")

function ExplosionSystem:fireEvent(event)
    local entity = event.entity
    local exp = entity:getComponent("PositionComponent")
    for i, v in pairs(engine.IsEnemy) do 
        local enemypos = v:getComponent("PositionComponent")
        if (math.sqrt((enemypos.x-exp.x)^2 + (enemypos.y-exp.y)^2)) < entity:getComponent("ExplosionComponent").radius then
            v:getComponent("LifeComponent").life = v:getComponent("LifeComponent").life - entity:getComponent("ExplosionComponent").damage
        end
    end
    engine:removeEntity(entity)
    if entity.components.PhysicsComponent then
        DestroyBody(entity)
    end
    explo = Entity()
    explo:addComponent(ParticleComponent(resources.images.blood1, 400, 400, (entity:getComponent("ExplosionComponent").radius*3), (entity:getComponent("ExplosionComponent").radius*3), 2.0, 2.3, 
                                            220, 100, 0, 80, 220, 0, 0, 140, 
                                            exp.x, exp.y, 0.2, 0.2, 0.3, 0, 360, 
                                            0, 360, 50, 100))
    engine:addEntity(explo)
    explo.components.ParticleComponent.hit:start()
end