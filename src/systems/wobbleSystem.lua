WobbleSystem = class("WobbleSystem", System)

function WobbleSystem:update() 
    for key, entity in pairs(self.targets) do
        local drawable = entity:getComponent("Drawable")
        local wobbly = entity:getComponent("Wobbly")
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
    return {"Drawable", "Wobbly"}
end

function WobbleSystem:updateSy(entity)
    if entity and entity:getComponent("Drawable") and entity:getComponent("Wobbly") then
        local drawable = entity:getComponent("Drawable")
        local wobbly = entity:getComponent("Wobbly")
        drawable.sy = 3*(wobbly.default / 4)
    end
end