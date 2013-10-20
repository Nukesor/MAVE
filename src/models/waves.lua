Wave = class("Wave")

function Wave:getRandomSpawnPosition()
    local result = {x= 100, y= math.random(0, love.graphics.getHeight()*0.9)}
    return result
end

Wave1 = class("Wave1", Wave)

function Wave1:getWave()
    local wave = {}
    for i=1, 10, 1 do
        local pos = self:getRandomSpawnPosition()
        local enemy = CutieModel(pos.x, pos.y, resources.images.cutie1, 20)
        enemy:addComponent(BloodComponent(1))
        enemy:addComponent(IsEnemy())
        table.insert(wave, enemy)
    end
    return wave
end
