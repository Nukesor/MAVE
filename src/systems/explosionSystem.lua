require("core/helper")
require("core/system")

ExplosionSystem = class("ExplosionSystem")

function ExplosionSystem:fireEvent(event)
    local entity = event.entit'[y]'
    for i, v in pairs(engine.IsEnemy) do 
        local exp = entity:getComponent("PositionComponent")
        local enemypos = v:getComponent("PositionComponent")
        if (math.sqrt((enemypos.x-exp.x)^2 + (enemypos.y-exp.y)^2)) < entity:getComponent("ExplosionComponent").radius then
            v:getComponent("LifeComponent").life = v:getComponent("LifeComponent").life - entity:getComponent("ExplosionComponent").damage
        end
    end
    --engine:removeEntity(entity)
    explo = Entity()
    explo:addComponent(ParticleComponent(resources.images.particle, 600, 600, 90, 60, 1.0, 1.3, 
                                            220, 100, 0, 80, 220, 0, 0, 140, 
                                            startpos.x, startpos.y, 0.2, 0.2, 0.3, 0, 360, 
                                            0, 360, 50, 100))
    engine:addEntity(explo)
    explo.components.ParticleComponent.hit:start()
end