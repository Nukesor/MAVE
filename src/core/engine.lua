require("core/helper")

Engine = class("Engine")

function Engine:__init() 
    self.entities = {}

    self.allSystems = {}
    self.logicSystems = {}
    self.renderSystems = {}
end

function Engine:addEntity(entity)
    table.insert(self.entities, entity)
    for index1, system in pairs(self.systems) do
        local flag = 1
        for index2, reqComp in pairs(system:requiredComponent()) do
            if flag == 1 then
                for index3, component in pairs(entity.components) do
                    if component.__name == reqComp then
                        flag = 1
                        break
                    else 
                        flag = 0
                    end
                end
            else
                break
            end
            if index2 == #system:requiredComponent() and flag == 1 then
                system:addEntity(entity)
            end
        end
    end
end

function Engine:removeEntity(entity)
    for index1, target in pairs(self.systems) do
        local flag = 1
        for index2, reqcomponent in pairs(target:requiredComponent()) do
            if flag == 1 then
                for index3, component in pairs(entity.components) do
                    if reqcomponent == component.__name then
                        flag = 1
                        break
                    else
                        flag = 0
                    end
                end
            else
                break
            end
            if index2 == #target:requiredComponent() and flag == 1 then
                target:removeEntity(entity)
            end
        end
    end
    for index, entity in pairs(self.entities) do
        if entity == entity then
            table.remove(self.entities, index)
            break
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
