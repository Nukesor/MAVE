WobbleSystem = class("WobbleSystem", System)

function WobbleSystem:update() 
    for key, entity in pairs(self.targets) do
        local drawable = entity:getComponent("Drawable")
        local bouncy = entity:getComponent("Bouncy")
        if drawable.sy < bouncy.default then
            drawable.sy = drawable.sy + (bouncy.default / 70)
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
    return {"Drawable", "Bouncy"}
end

function WobbleSystem:updateSy(entity)
    if entity and entity:getComponent("Drawable") and entity:getComponent("Bouncy") then
        local drawable = entity:getComponent("Drawable")
        local bouncy = entity:getComponent("Bouncy")
        drawable.sy = 3*(bouncy.default / 4)
    end
end