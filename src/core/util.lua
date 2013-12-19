-- Destroys an entity's body and removes it from the engine
function removeEntityWithPhysics(entity)
    stack:current().engine.entities[entity.id]:getComponent("PhysicsComponent").body:destroy()
    stack:current().engine:removeEntity(entity)
end

-- Returns the key of an element inside that table
function table.getKey(table, element)
    for index, value in pairs(table) do
        if value == element then
            return index
        end
    end
    return false
end


function table.firstElement(table)
    for index, value in pairs(table) do
        return value
    end
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

function relation()
    local x = set.settings.resolution[1]/1920
    return x
end

function saveSettings()
    if love.filesystem.exists("settings.lua") then
        love.filesystem.remove("settings.lua")
    end
    love.filesystem.newFile("settings.lua")
    success = love.filesystem.write("settings.lua", table.show(set.settings, "settings"))
end

function loadSettings()
    if love.filesystem.exists("settings.lua") then
        chunk = love.filesystem.load("settings.lua")
        chunk()
        set.settings = settings
        refreshSettings()
        return true
    else
        return false
    end
end

function refreshSettings()
    love.window.setMode(set.settings.resolution[1], set.settings.resolution[2], {fullscreen=set.settings.fullscreen, resizable=false, vsync=true})
end

function saveGame()
    if love.filesystem.exists("stats.lua") then
        love.filesystem.remove("stats.lua")
    end
    love.filesystem.newFile("stats.lua")
    success = love.filesystem.write("stats.lua", table.show(gameplay.stats, "stats"))
end

function loadGame()
    if love.filesystem.exists("stats.lua") then
        chunk = love.filesystem.load("stats.lua")
        chunk()
        gameplay.stats = stats
        for i, v in pairs(gameplay.items) do
            v.owned = gameplay.stats.owned[i]
        end
        return true
    else
        return false
    end
end

function table.show(t, name, indent)
   local cart     -- a container
   local autoref  -- for self references

   --[[ counts the number of elements in a table
   local function tablecount(t)
      local n = 0
      for _, _ in pairs(t) do n = n+1 end
      return n
   end
   ]]
   -- (RiciLake) returns true if the table is empty
   local function isemptytable(t) return next(t) == nil end

   local function basicSerialize (o)
      local so = tostring(o)
      if type(o) == "function" then
         local info = debug.getinfo(o, "S")
         -- info.name is nil because o is not a calling level
         if info.what == "C" then
            return string.format("%q", so .. ", C function")
         else 
            -- the information is defined through lines
            return string.format("%q", so .. ", defined in (" ..
                info.linedefined .. "-" .. info.lastlinedefined ..
                ")" .. info.source)
         end
      elseif type(o) == "number" or type(o) == "boolean" then
         return so
      else
         return string.format("%q", so)
      end
   end

   local function addtocart (value, name, indent, saved, field)
      indent = indent or ""
      saved = saved or {}
      field = field or name

      cart = cart .. indent .. field

      if type(value) ~= "table" then
         cart = cart .. " = " .. basicSerialize(value) .. ";\n"
      else
         if saved[value] then
            cart = cart .. " = {}; -- " .. saved[value] 
                        .. " (self reference)\n"
            autoref = autoref ..  name .. " = " .. saved[value] .. ";\n"
         else
            saved[value] = name
            --if tablecount(value) == 0 then
            if isemptytable(value) then
               cart = cart .. " = {};\n"
            else
               cart = cart .. " = {\n"
               for k, v in pairs(value) do
                  k = basicSerialize(k)
                  local fname = string.format("%s[%s]", name, k)
                  field = string.format("[%s]", k)
                  -- three spaces between levels
                  addtocart(v, fname, indent .. "   ", saved, field)
               end
               cart = cart .. indent .. "};\n"
            end
         end
      end
   end

   name = name or "__unnamed__"
   if type(t) ~= "table" then
      return name .. " = " .. basicSerialize(t)
   end
   cart, autoref = "", ""
   addtocart(t, name, indent)
   return cart .. autoref
end
