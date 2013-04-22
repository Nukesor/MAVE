WobbleSystem = class("WobbleSystem", System)

function WobbleSystem:update() 
    for key, entity in pairs(self.targets) do
        local drawable = entity:getComponent("DrawableComponent")
        local wobbly = entity:getComponent("WobblyComponent")
        if drawable.sy < wobbly.default then
            drawable.sy = drawable.sy + (wobbly.default / 70)
        end
    end
end

function WobbleSystem:beginContact(a, b, coll)
    local entityA = a:getUserData()[2]
    local entityB = b:getUserData()[2]
    self:updateSy(entityA)
    self:updateSy(entityB)
end

function WobbleSystem:getRequiredComponents()
    return {"DrawableComponent", "WobblyComponent"}
end

function WobbleSystem:updateSy(entity)
    if entity and entity:getComponent("DrawableComponent") and entity:getComponent("WobblyComponent") then
        local drawable = entity:getComponent("DrawableComponent")
        local wobbly = entity:getComponent("WobblyComponent")
        drawable.sy = 3*(wobbly.default / 4)
    end
end