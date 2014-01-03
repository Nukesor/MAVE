-- Destroys an entity's body and removes it from the engine
function removeEntityWithPhysics(entity)
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
end

function insideRadius(entity1, entity2, radius)
    position1 = entity1:getComponent("PositionComponent")
    position2 = entity2:getComponent("PositionComponent")
    if distanceBetween({position1.x, position1.y}, {position2.x, position2.y}) <= radius
    or distanceBetween({position1.x - love.graphics.getWidth(), position1.y}, {position2.x, position2.y}) <= radius
    or distanceBetween({position1.x + love.graphics.getWidth(), position1.y}, {position2.x, position2.y}) <= radius then
        return true
    else
        return false
    end
end

function getMid(entity1, entity2)
    local x1, y1 = entity1:getComponent("PositionComponent").x, entity1:getComponent("PositionComponent").y
    local x2, y2 = entity2:getComponent("PositionComponent").x, entity2:getComponent("PositionComponent").y

    return (x1 + x2)/2 , (y1 + y2)/2 
end

function getSinCos(x, y, xt, yt)
    local akat, gkat
    akat = xt - x
    gkat = yt - y

    local hypo = math.sqrt(math.pow(gkat, 2) + math.pow(akat, 2))
    local sin = gkat/hypo
    local cos = akat/hypo
    return sin, cos
end

function getRadian(x, y, xt, yt)
    local akat, gkat
    akat = xt - x
    gkat = yt - y
    return math.atan2(akat, -gkat)-math.pi/2
end

function getAngle(x, y, xt, yt)
    return getRadian(x, y, xt, yt) * 180/math.pi
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

function sortItemMenu(table, length)
    for index, box in pairs(table) do
        if (index % length) == 0 then
            box:getComponent("BoxComponent").linked[1] = table[index-1]
            box:getComponent("BoxComponent").linked[2] = table[index-length+1]
        elseif (index % length) == 1 then
            box:getComponent("BoxComponent").linked[1] = table[index+length-1]
            box:getComponent("BoxComponent").linked[2] = table[index+1]
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
    for index, value in pairs(stack:current().engine:getEntityList("BoxComponent")) do
        if value:getComponent("BoxComponent").selected == true then 
            return value
        end
    end
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

function relation()
    local x = set.settings.resolution[1]/1920
    return x
end
