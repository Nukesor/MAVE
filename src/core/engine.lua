require("core/helper")

Engine = class("Engine")

function Engine:__init() 
    self.entities = {}

    self.allSystems = {}
    self.logicSystems = {}
    self.renderSystems = {}
end

function Engine:addEntity(entity)
    for index, system in pairs(self.allSystems) do
        local add = true
        for index, requiredComponent in pairs(system:getRequiredComponents()) do
            if not entity.components[requiredComponent] then
                add = false
            end
        end

        if add == true then
            system:addEntity(entity)
        end
    end
    table.insert(self.entities, entity)
end

function Engine:removeEntity(entity)
    for key, system in pairs(self.allSystems) do
        for key2, systemEntity in pairs(system:getEntities()) do
            if systemEntity == entity then    
                system:removeEntity(entity)
            end
        end
    end
end

function Engine:addSystem(system, type)
    if type == "render" then
        table.insert(self.renderSystems, system)
    elseif type == "logic" then
        table.insert(self.logicSystems, system)
    end
    table.insert(self.allSystems, system)
end

function Engine:update(dt)
    for index, system in ipairs(self.logicSystems) do
        system:update(dt)
    end
end

function Engine:draw()
    for index, system in ipairs(self.renderSystems) do
        system:update()
    end
end
