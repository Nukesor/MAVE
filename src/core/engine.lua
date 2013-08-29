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
    entity.id = math.random(0,255)
    table.insert(entities[entity.id], entity)
    -- Eingliederung der Entity in die jeweilige ComponentList
    for index, component in pairs(entity.components) do
        if self[component.__name] then
            table.insert(self[component.__name], entity)
        end
    end
end 

function Engine:removeEntity(entity)
    local index
    for i, v in pairs(self.entities[entity.id]) do
        if v ==  enitity then
            index = i
        end
    end
    --[[
        if self.entities[entity.id][index] then
            for i, component in pairs(entity.components) do
                if self.requirements[component.__name] then
                    for i2, system in self.requirements[component.__name] do
                        for i3, ent in pairs(system.entities) do
                            if ent == entity then
                                table.remove(system.entities, i3)
                            end
                        end
                    end
                end
            end
        end
    --]]
    if self.entities[entity.id][index] then
        for key, system in pairs(self.allSystems) do
            for key2, systemEntity in pairs(system:getEntities()) do
                if systemEntity == entity then    
                    system:removeEntity(entity)
                end
            end
        end
        table.remove(self.entities[entity.id], index)
    end

    -- Löschen der jeweiligen Entity aus der ComponentList
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
    if type == "draw" then
        table.insert(self.drawSystems, system)
    elseif type == "logic" then
        self.logicSystems[index] = system
    end
    table.insert(self.allSystems, system)
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
end

function Engine:refreshEntity(entity)
-- function Engine:refreshEntity(entity, added, removed)
    --[[
    if removed then
        for i, component in pairs(removed) do
            if self.requirements[component.__name] then
                system:removeEntity(entity)
            end
        end
    end
    if added then
        for i, component in pairs(added) do
            if self.requirements[component.__name] then
                for i2, system in self.requirements[component.__name] do
                    local add == true
                    for i3, req in pairs(system.getRequiredComponents()) do
                        for i3, comp in pairs(entity.components) do
                            if comp.__name == req then
                                add == true
                                break
                            else
                                add == false
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
    --]]
    for index, system in pairs(self.allSystems) do
        local add = true
        local remove = false
        for index2, target in pairs(system:getEntities()) do
            if target == entity then
                add = false
            end
        end
        for index3, requiredComponent in pairs(system:getRequiredComponents()) do
            if not entity.components[requiredComponent] then
                add = false
                remove = true
            end
        end
        if add then
            system:addEntity(entity)
        elseif remove then
            system:removeEntity(entity)
        end
    end
end

-- Event stuff
function Engine:addListener(eventName, listener)
    if not self.eventListeners[eventName] then
        self.eventListeners[eventName] = {}
    end
    self.eventListeners[eventName][listener.__name] = listener
end

function Engine:removeListener(eventName, listener)
    if self.eventListeners[eventName] and self.eventListeners.eventName.listener then
        self.eventListeners[eventName][listener.__name] = nil
    end
end

function Engine:fireEvent(event)
    if self.eventListeners[event.__name] then
        for k,v in pairs(self.eventListeners[event.__name]) do
            v:fireEvent(event)
        end
    end
end

function Engine:getEntitylist(component)
    if self[component] then
        return self[component]
    else
        self[component] = {}
        for index, entity in pairs(self.entities) do
            for index2, components in pairs(entity.components) do
                if components.__name == component then
                    table.insert(self[component], entity)
                    break
                end
            end
        end
        return self[component]
    end
end