Wave = class("Wave")

function Wave:getRandomSpawnPosition()
    local result = {x= 100, y= love.math.random(0, love.graphics.getHeight()*0.9)}
    return result
end

Wave1 = class("Wave1", Wave)

function Wave1:getWave()
    local wave = {}
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie0, 5)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end

Wave2 = class("Wave2", Wave)

function Wave2:getWave()
    local wave = {}
    for i=1, 15, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie2, 7)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end


Wave3 = class("Wave3", Wave)

function Wave3:getWave()
    local wave = {}
    for i=1, 5, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie3, 20)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end



Wave4 = class("Wave4", Wave)

function Wave4:getWave()
    local wave = {}
    for i=1, 20, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie3, 30)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end

Wave5 = class("Wave5", Wave)

function Wave5:getWave()
    local wave = {}
    for i=1, 5, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie4, 50)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end


Wave6 = class("Wave6", Wave)

function Wave6:getWave()
    local wave = {}
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie4, 50)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end

Wave7 = class("Wave7", Wave)

function Wave7:getWave()
    local wave = {}
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie4, 50)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie2, 20)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end

Wave8 = class("Wave8", Wave)

function Wave8:getWave()
    local wave = {}
    local pos = self:getRandomSpawnPosition()
    local enemy = CutieModel(pos.x, pos.y, resources.images.cutie5, 300)
    enemy:add(BloodComponent(1))
    enemy:add(IsEnemy())
    table.insert(wave, enemy)
    return wave
end


Wave9 = class("Wave9", Wave)

function Wave9:getWave()
    local wave = {}
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie4, 50)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie2, 20)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 7, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie3, 30)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end

Wave10 = class("wave10", Wave)

function Wave10:getWave()
local wave = {}
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie0, 5)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 15, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie2, 7)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 15, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie3, 20)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 15, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie4, 50)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie2, 20)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    for i=1, 2, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie5, 300)
        enemy:add(BloodComponent(1))
        enemy:add(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end