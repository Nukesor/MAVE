EnemySpawnSystem = class("EnemySpawnSystem", System)

function EnemySpawnSystem:__init()
    
    self.spawntimer = 0
    self.fire = false
end

function EnemySpawnSystem:update(dt)

    self.spawntimer = self.spawntimer + dt
    -- Everytime the timer is full an enemy is spawned at the screenside with a random height. 
    if self.spawntimer > 3 then
        local height = math.random(300, 500)
        local cutie
        cutie = CutieModel(0, height, resources.images.cutie2, 15)
        cutie:addComponent(IsEnemy())
        cutie:addComponent(GoldComponent(10))
        stack:current().engine:addEntity(cutie)
        self.spawntimer = 0 
    end
end

function EnemySpawnSystem:getRequiredComponents()
    return {}
end