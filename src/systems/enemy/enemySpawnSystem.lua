EnemySpawnSystem = class("EnemySpawnSystem", System)

function EnemySpawnSystem:__init()
    self.waitUntilSpawn = 5
    self.waveIndex = 1
    self.wave = gameplay.waves[self.waveIndex]:getWave()
end

function EnemySpawnSystem:update(dt)
    if next(stack:current().engine:getEntitylist("IsEnemy")) == nil then
        self.waitUntilSpawn = self.waitUntilSpawn - dt
    end

    if self.waitUntilSpawn <= 0 then
        if gameplay.waves[self.waveIndex+1] then
            self.waveIndex = self.waveIndex + 1
        end

        self.wave = gameplay.waves[self.waveIndex]:getWave()

        for index, enemy in pairs(self.wave) do
            stack:current().engine:addEntity(enemy)
        end

        self.waitUntilSpawn = 5
    end
end

function EnemySpawnSystem:getRequiredComponents()
    return {}
end
