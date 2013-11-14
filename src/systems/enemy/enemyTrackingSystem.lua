EnemyTrackingSystem = class("EnemyTrackingSystem", System)

function EnemyTrackingSystem:update(dt)
    for index, entity in pairs(self.targets) do
        local height
        local enemy=entity:getComponent("IsEnemy")
        local playercutiex, playercutiey = playercutie:getComponent("PositionComponent").x, playercutie:getComponent("PositionComponent").y
        local xpos, ypos = entity:getComponent("PositionComponent").x, entity:getComponent("PositionComponent").y
        local speed = stack:current().worldspeed or 1

        -- Ki
        if ypos <= love.graphics.getHeight() * (6/6) - love.graphics.getHeight()/60   then
            height = love.graphics.getHeight() * (5/6)
            if ypos <= love.graphics.getHeight() * (5/6) - love.graphics.getHeight()/60 then
                height = love.graphics.getHeight() * (4/6)
                if ypos <= love.graphics.getHeight() * (4/6) - love.graphics.getHeight()/60  then
                    height = love.graphics.getHeight() * (3/6)
                    if ypos <= love.graphics.getHeight() * (3/6) - love.graphics.getHeight()/60  then
                        height = love.graphics.getHeight() * (2/6)
                        if ypos <= love.graphics.getHeight() * (2/6) - love.graphics.getHeight()/60  then
                            height = love.graphics.getHeight() * (1/6)
                            if ypos <= love.graphics.getHeight() * (1/6) - love.graphics.getHeight()/60  then
                                height = love.graphics.getHeight() * (0/6)
                            end
                        end
                    end
                end
            end
        end

        if playercutiey < height then
            if enemy.check == 0 then
                enemy.check = 1
                if playercutiex > 500 then
                    enemy.direction = 1
                elseif playercutiey < 500 then
                    enemy.direction = 0
                end
            end

            if xpos <= (love.graphics:getWidth()* 2/10 + (love.graphics:getWidth()/200-height/(love.graphics:getHeight()/10))*love.graphics:getWidth()/20) 
                    or xpos >= (love.graphics:getWidth()*6/10 - (love.graphics:getWidth()/200-height/(love.graphics:getHeight()/10))*love.graphics:getWidth()/20) then
                enemy.check = 0
                entity:getComponent("PhysicsComponent").body:applyLinearImpulse(0, -love.graphics:getHeight()/100)
                if ypos > love.graphics:getHeight()/2 then
                    if xpos < playercutiex and (playercutiex - xpos) < love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif xpos < playercutiex and (playercutiex - xpos) > love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) < love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) > love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                    end
                else
                    if playercutiex > xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif playercutiex < xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                    end
                end  
            else
                if enemy.direction == 1 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                elseif enemy.direction == 0 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                end
            end

        elseif playercutiey > (height+love.graphics:getHeight()/6) then
            if enemy.check == 0 then
                enemy.check = 1
                if playercutiex > love.graphics:getWidth()/2 then
                    enemy.direction = 1
                elseif playercutiex < love.graphics:getWidth()/2 then
                    enemy.direction = 0
                end
            end
            if  xpos < (love.graphics:getWidth() * 4/10 - love.graphics:getWidth()/100 - (height/(love.graphics:getHeight()/10))*love.graphics:getWidth()/20) 
                or xpos > (love.graphics:getWidth() * 6/10 + love.graphics:getWidth()/100 + (height/(love.graphics:getHeight()/10))*love.graphics:getWidth()/20) then
                enemy.check = 0
                if ypos > love.graphics:getHeight()/2 then
                    if xpos < playercutiex and (playercutiex - xpos) < love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif xpos < playercutiex and (playercutiex - xpos) > love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) < love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) > love.graphics:getWidth()/2 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                    end
                else
                    if playercutiex > xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                    elseif playercutiex < xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                    end
                end
            else
                if enemy.direction == 1 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                elseif enemy.direction == 0 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                end
            end
        else
            enemy.check = 0
            if ypos > love.graphics:getHeight()/2 then
                if xpos < playercutiex and (playercutiex - xpos) < love.graphics:getWidth()/2 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                elseif xpos < playercutiex and (playercutiex - xpos) > love.graphics:getWidth()/2 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) < love.graphics:getWidth()/2 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) > love.graphics:getWidth()/2 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                end
            else
                if playercutiex > xpos then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( love.graphics:getWidth()/2000*speed * dt*50, 0)
                elseif playercutiex < xpos then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -love.graphics:getWidth()/2000*speed * dt*50, 0)
                end
            end  
         end
    end
end

function EnemyTrackingSystem:getRequiredComponents()
    return{"IsEnemy"}
end
