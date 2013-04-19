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
    entity.index = self.entityIndex
    self.entityIndex = self.entityIndex + 1
    self:refreshEntity(entity)
end


function Engine:removeEntity(entity)
    if self.entities[entity.index] then
        for key, system in pairs(self.allSystems) do
            for key2, systemEntity in pairs(system:getEntities()) do
                if systemEntity == entity then    
                    system:removeEntity(entity)
                end
            end
        end
        self.entities[entity.index] = nil
        entity.index = nil
    end
end


function Engine:addSystem(system, type)
    if type == "draw" then
        table.insert(self.drawSystems, system)
    elseif type == "logic" then
        table.insert(self.logicSystems, system)
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
    if not self.entities[entity.index] then
        return
    end
    for index, system in pairs(self.allSystems) do
        local add = true
        for index, requiredComponent in pairs(system:getRequiredComponents()) do
            if not entity.components[requiredComponent] then
                add = false
            end
        end

        if add == true then
            system:addEntity(entity)
        elseif add == false then
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