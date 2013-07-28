EnemySpawnSystem = class("EnemySpawnSystem", System)

function EnemySpawnSystem:__init()
    
    self.spawntimer = 0
    self.fire = false
end

function EnemySpawnSystem:update(dt)

    self.spawntimer = self.spawntimer + dt

    if self.spawntimer > 3 then 
        self.fire = false
    end

    if self.fire == true then
            local height = math.random(300, 500)
            local cutie

            cutie = CutieModel(0, height, resources.images.cutie2, 15)
            cutie:addComponent(IsEnemy())
            cutie:addComponent(GoldComponent(10))
            stack:current().engine:addEntity(cutie)
    end

    if self.fire == true then
        self.spawntimer = 0
        self.fire = false
    end
end

function EnemySpawnSystem:getRequiredComponents()
    return {}
end