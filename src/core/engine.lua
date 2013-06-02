require("core/helper")

Engine = class("Engine")

function Engine:__init() 
    self.entities = {}

    self.allSystems = {}
    self.logicSystems = {}
    self.drawSystems = {}

    self.events = {}

    self.entityIndex = 0
end

function Engine:addEntity(entity)
    self.entities[self.entityIndex] = entity
    entity.id = self.entityIndex
    self.entityIndex = self.entityIndex + 1
    self:refreshEntity(entity)
    EntityLists:addEntity(entity)
end


function Engine:removeEntity(entity)
    if self.entities[entity.id] then
        for key, system in pairs(self.allSystems) do
            for key2, systemEntity in pairs(system:getEntities()) do
                if systemEntity == entity then    
                    system:removeEntity(entity)
                end
            end
        end
        self.entities[entity.id] = nil
    end
    EntityLists:removeEntity(entity)
end


function Engine:addSystem(system, type, index)
    if type == "draw" then
        table.insert(self.drawSystems, system)
    elseif type == "logic" then
        self.logicSystems[index] = system
    end
    table.insert(self.allSystems, system)
    return system
end


function Engine:update(dt)
    for index, system in ipairs(self.logicSystems) do
        system:update(dt)
    end
end


function Engine:draw()
    for index, system in ipairs(self.drawSystems) do
        system:update()
    end
end


function Engine:refreshEntity(entity)
    if not self.entities[entity.id] then
        return
    end
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

function Engine:addListener(eventName, listener)
    if not self.events[eventName] then
        self.events[eventName] = {}
    end
    self.events[eventName][listener.__name] = listener
end

function Engine:removeListener(eventName, listener)
    if self.events[eventName] and self.events.eventName.listener then
        self.events[eventName][listener.__name] = nil
    end
end

function Engine:fireEvent(event)
    if self.events[event.name] then
        for k,v in pairs(self.events[event.name]) do
            v:fireEvent(event)
        end
    end
end