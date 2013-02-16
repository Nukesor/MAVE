Engine = class("Engine")

function Engine:__init() 
    self.entities = {}

    self.allSystems = {}
    self.logicSystems = {}
    self.renderSystems = {}
end

function Engine:addEntity(entity)
    for index, system in ipairs(self.allSystems) do
        local add = true
        for index, requiredComponent in ipairs(system:getRequiredComponents()) do
            if not entity.components[requiredComponent] then
                add = false
            end
        end

        if add == true then
            for index, component in ipairs(system:getRequiredComponents()) do
                system:addComponent(entity.components[component])
            end
        end
    end
    table.insert(self.entities, entity)
end

function Engine:addSystem(system, type)
    if type == "render" then
        table.insert(self.renderSystems, system)
    elseif type == "logic" then
        table.insert(self.logicSystems, system)
    end
    table.insert(self.allSystems, system)
end

function Engine:update()
    for index, system in ipairs(self.logicSystems) do
        system:update()
    end
end

function Engine:draw()
    for index, system in ipairs(self.renderSystems) do
        system:update()
    end
end