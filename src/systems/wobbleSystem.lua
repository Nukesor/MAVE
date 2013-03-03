WobbleSystem = class("WobbleSystem", System)

function WobbleSystem:update()
    for key, entity in pairs(self.targets) do
        local body = entity:getComponent("Physics").body
        if body:getY() > 560 then
            entity:getComponent("Drawable").sy = 0.1-((body:getY()-560)/100)
        else
            entity:getComponent("Drawable").sy = 0.1
        end
    end
end

function WobbleSystem:getRequiredComponents()
    return {"Drawable", "Physics"}
end