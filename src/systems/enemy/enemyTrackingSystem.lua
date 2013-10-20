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

            if xpos <= (200 + (5-height/100)*50) or xpos >= (800 - (5-height/100)*50) then
                enemy.check = 0
                entity:getComponent("PhysicsComponent").body:applyLinearImpulse(0, -6)
                if ypos > 300 then
                    if xpos < playercutiex and (playercutiex - xpos) < 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                    elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                    end
                else
                    if playercutiex > xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                    elseif playercutiex < xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                    end
                end  
            else
                if enemy.direction == 1 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                elseif enemy.direction == 0 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                end
            end

        elseif playercutiey > (height+100) then
            if enemy.check == 0 then
                enemy.check = 1
                if playercutiex > 500 then
                    enemy.direction = 1
                elseif playercutiex < 500 then
                    enemy.direction = 0
                end
            end
            if  xpos < (390 - (height/100)*50) or xpos > (610 + (height/100)*50) then
                enemy.check = 0
                if ypos > 300 then
                    if xpos < playercutiex and (playercutiex - xpos) < 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                    elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                    elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                    end
                else
                    if playercutiex > xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                    elseif playercutiex < xpos then
                        entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                    end
                end
            else
                if enemy.direction == 1 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                elseif enemy.direction == 0 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                end
            end
        else
            enemy.check = 0
            if ypos > 300 then
                if xpos < playercutiex and (playercutiex - xpos) < 500 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                end
            else
                if playercutiex > xpos then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( 0.5*speed, 0)
                elseif playercutiex < xpos then
                    entity:getComponent("PhysicsComponent").body:applyLinearImpulse( -0.5*speed, 0)
                end
            end  
         end
    end
end

function EnemyTrackingSystem:getRequiredComponents()
    return{"IsEnemy"}
end
