function DestroyBody(entity)
    local physics = entity:getComponent("PhysicsComponent")
    physics.body:destroy()
    stack:current().engine:removeEntity(entity)
end

function distanceBetween(pos1, pos2)
    relativeX = pos1[1] - pos2[1]
    relativeY = pos1[2] - pos2[2]
    return math.sqrt(relativeX*relativeX + relativeY*relativeY)
end

function sortMenu(table)
    for index, box in pairs(table) do
        if index == 1 then
            box:getComponent("BoxComponent").linked[1] = table[#table]
            box:getComponent("BoxComponent").linked[2] = table[index+1]
        elseif index == #table then
            box:getComponent("BoxComponent").linked[1] = table[index-1]
            box:getComponent("BoxComponent").linked[2] = table[1]
        else
            box:getComponent("BoxComponent").linked[1] = table[index-1]
            box:getComponent("BoxComponent").linked[2] = table[index+1]
        end
    end
end