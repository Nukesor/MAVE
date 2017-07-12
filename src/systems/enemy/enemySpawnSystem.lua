EnemySpawnSystem = class("EnemySpawnSystem", System)

function EnemySpawnSystem:initialize()
    self.waitUntilSpawn = 5
    self.waveIndex = 1
end

function EnemySpawnSystem:update(dt)
    if next(stack:current().engine:getEntityList("IsEnemy")) == nil then
        self.waitUntilSpawn = self.waitUntilSpawn - dt
    end

    if self.waitUntilSpawn <= 0 then
        if gameplay.waves[self.waveIndex+1] then
            self.waveIndex = self.waveIndex + 1
        end

        for index, enemy in pairs(gameplay.waves[self.waveIndex]:getWave()) do
            stack:current().engine:addEntity(enemy)
        end

        self.waitUntilSpawn = 5
    end
end
