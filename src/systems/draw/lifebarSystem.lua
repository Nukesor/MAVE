LifebarSystem = class("LifebarSystem", System)

function LifebarSystem:draw()
    for index, value in pairs(self.targets) do
        local position = value:get("PositionComponent")
        local life = value:get("LifeComponent")
        local hp = life.life
        -- Draws a healthbar above Entity. If life is below 0 it resets to 0, Otherwise huge healthbars will be displayed.
        if hp < 0 then 
            hp = 0
        end
        love.graphics.setColor(255, 0, 0, 150)
        love.graphics.rectangle("fill", position.x-8, position.y-20, 20, 4)
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.rectangle("fill", position.x-8, position.y-20, 20*(hp/life.maxlife), 4)
    end
end


function LifebarSystem:requires()
    return {"LifeComponent"}
end