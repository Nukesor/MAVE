Engine = class("Engine")

function Engine:__init() 
    self.entities = {}
    self.entityIndex = 0
    self.requirements = {}

    self.allSystems = {}
    self.logicSystems = {}
    self.drawSystems = {}

    self.eventListeners = {}
end

function Engine:addEntity(entity)
    -- Every Entity gets a random Hashnumber and gets added to its hashtable
    entity.id = math.random(0,255)
    if self.entities[entity.id] == nil then 
        self.entities[entity.id] = {}
    end
    table.insert(self.entities[entity.id], entity)

    for index, component in pairs(entity.components) do
    -- Adding Entity to specific Entitylist if already existing
        if self[component.__name] then
            table.insert(self[component.__name], entity)
        end
    -- Adding Entity to System if all requirements are granted
        if self.requirements[component.__name] then
            for index2, system in pairs(self.requirements[component.__name]) do
                local check = true
                for index3, requirement in pairs(system:getRequiredComponents()) do
                    if check == true then
                        for index4, component in pairs(entity.components) do
-- adding Entity to componentlist. VORRUEBERGEHENDE LOESUNG! ABSPRECHEN MIT RAFAEL UND VLT. DEBUGGEN!
                            if self[component.__name] then
                                table.insert(self[component.__name], entity)
                            else
                                self[component.__name] = {}
                                table.insert(self[component.__name], entity)
                            end
--]]
                            if component.__name == requirement then
                                check = true
                                break
                            else
                                check = false
                            end
                        end
                    else
                        break 
                    end
                end
                if check == true then
                    system:addEntity(entity)
                end
            end
        end
    end
end 

function Engine:removeEntity(entity)
    -- getting the index of Entity
    local index
    for i, v in pairs(self.entities[entity.id]) do
        if v ==  entity then
            index = i
        end
    end
    -- Removing the Entity from all Systems and engine
    if self.entities[entity.id][index] then
        for i, component in pairs(entity.components) do
            if self.requirements[component.__name] then
                for i2, system in pairs(self.requirements[component.__name]) do
                    for i3, ent in pairs(system.targets) do
                        if ent == entity then
                            table.remove(system.targets, i3)
                        end
                    end
                end
            end
        end
        table.remove(self.entities[entity.id], index)
    end

    -- Deleting the Entity from the specific entity lists
    for index, component in pairs(entity.components) do
        if self[component.__name] then
            for index2, ent in pairs(self[component.__name]) do
                if entity == ent then 
                    table.remove(self[component.__name], index2)
                end
            end
        end
    end
end

function Engine:addSystem(system, type, index)
    -- Adding System to draw or logic table
    if type == "draw" then
        table.insert(self.drawSystems, system)
    elseif type == "logic" then
        self.logicSystems[index] = system
    end
    table.insert(self.allSystems, system)
    -- Registering the systems requirements and saving them in a special table for fast access
    for index, value in pairs(system:getRequiredComponents()) do
        if not self.requirements[value] then
            self.requirements[value] = {}
        end
        table.insert(self.requirements[value], system)
    end
    return system
end

function Engine:update(dt)
    for index, system in ipairs(self.logicSystems) do
        system:update(dt)
    end
end

function Engine:draw()
    for index, system in ipairs(self.drawSystems) do
        system:draw()
    end
    -- Enable to get white boxes around Bodies with polygonshapes
    --[[ 
    for key, entity in pairs(self:getEntitylist("PhysicsComponent")) do
        x1, y1, x2, y2 = entity:getComponent("PhysicsComponent").fixture:getBoundingBox()
        if entity:getComponent("PhysicsComponent").shape.getPoints then
            love.graphics.polygon("fill", entity:getComponent("PhysicsComponent").body:getWorldPoints(entity:getComponent("PhysicsComponent").shape:getPoints()))
        end
    end
    --]]--
end

function Engine:refreshEntity(entity, added, removed)
    if removed then
        for i, component in pairs(removed) do
            -- Removing Entity from Entitylists
            if self[component] then
                for i2, ent in pairs(self[component]) do
                    if ent == entity then
                        table.remove(self[component], i2)
                        break
                    end
                end
            end
            -- Removing Entity from old systems
            if self.requirements[component] then
                for i2, system in pairs(self.requirements[component]) do 
                    system:removeEntity(entity)
                end
            end
        end
    end
    if added then
        for i, component in pairs(added) do
            -- Adding the Entity to Entitylist
            if self[component] then
                table.insert(self[component], entity)
            
            -- VORRUEBERGEHENDE LOESUNG. ABSPRECHEN MIt RAFAEL UND VIELLEICHT DEBUGGEN!
            else
                self[component] = {}
                table.insert(self[component], entity)
            

            end
            -- Adding the Entity to the requiring systems
            if self.requirements[component] then
                for i2, system in pairs(self.requirements[component]) do
                    local add = true
                    for i3, req in pairs(system.getRequiredComponents()) do
                        for i3, comp in pairs(entity.components) do
                            if comp.__name == req then
                                add = true
                                break
                            else
                                add = false
                            end
                        end
                    end
                    if add == true then
                        system:addEntity(entity)
                    end
                end
            end
        end
    end
end

-- Adding an eventlistener to a specific event
function Engine:addListener(eventName, listener)
    if not self.eventListeners[eventName] then
        self.eventListeners[eventName] = {}
    end
    self.eventListeners[eventName][listener.__name] = listener
end

-- Removing an eventlistener from an event
function Engine:removeListener(eventName, listener)
    if self.eventListeners[eventName] and self.eventListeners.eventName.listener then
        self.eventListeners[eventName][listener.__name] = nil
    end
end

-- Firing an event. All regiestered listener will react to this event
function Engine:fireEvent(event)
    if self.eventListeners[event.__name] then
        for k,v in pairs(self.eventListeners[event.__name]) do
            v:fireEvent(event)
        end
    end
end

-- Returns an Entitylist for a specific component. If the Entitylist doesn't exists yet it'll be created and returned.
function Engine:getEntitylist(component)
    if self[component] then
        return self[component]
    else
        self[component] = {}
--[[
        for index, table in pairs(self.entities) do
            for index2, entity in pairs(table) do
                for index3, comp in pairs(entity.components) do
                    if comp.__name == component then
                        table.insert(self[component], entity)
                        break
                    end
                end
            end
        end
--]]
        return self[component]
    end
end