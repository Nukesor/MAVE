-- Destroys an entity's body and removes it from the engine
function removeEntityWithPhysics(entity)
    --stack:current().engine.entities[entity.id]:getComponent("PhysicsComponent").body:destroy()
    stack:current().engine.entities[entity.id]:getComponent("PhysicsComponent").body:destroy()
    stack:current().engine:removeEntity(entity)
end

-- Returns the distance between the two Positions.
-- A position is  specified as a table with two values: {x, y}.
function distanceBetween(pos1, pos2)
    relativeX = pos1[1] - pos2[1]
    relativeY = pos1[2] - pos2[2]
    return math.sqrt(relativeX*relativeX + relativeY*relativeY)
end

function distanceBetweenEntities(entity1, entity2)
    position1 = entity1:getComponent("PositionComponent")
    position2 = entity2:getComponent("PositionComponent")
    return distanceBetween({position1.x, position1.y}, {position2.x, position2.y})
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

function sortMenuVertical(table)
    for index, box in pairs(table) do
        if index == 1 then
            box:getComponent("BoxComponent").linked[3] = table[#table]
            box:getComponent("BoxComponent").linked[4] = table[index+1]
        elseif index == #table then
            box:getComponent("BoxComponent").linked[3] = table[index-1]
            box:getComponent("BoxComponent").linked[4] = table[1]
        else
            box:getComponent("BoxComponent").linked[3] = table[index-1]
            box:getComponent("BoxComponent").linked[4] = table[index+1]
        end
    end
end

function getSelectedBox()
    for index, value in pairs(stack:current().engine:getEntitylist("BoxComponent")) do
        if value:getComponent("BoxComponent").selected == true then 
            return value
        end
    end
end

function deepcopy(orig)
    local copy
    if type(orig) == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function copy(orig)
    local copy
    if type(orig) == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else
        copy = orig
    end
    return copy
end

function resetIndice(thing)
    local newTable = {}
    if type(thing) == 'table' then
        for index, value in pairs(thing) do
            table.insert(newTable, value)
        end
    end
    return newTable
end

function equals(a, b)
    local equal = true
    for k, v in pairs(a) do
        if v ~= b[k] then
            equal = false
            break
        end
    end
    return equal
end