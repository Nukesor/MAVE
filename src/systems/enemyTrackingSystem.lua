require("core/helper")
require("core/system")

EnemyTrackingSystem = class("EnemyTrackingSystem", System)

function EnemyTrackingSystem:update(dt)
	for index, entity in pairs(self.targets) do
		local height
		local enemy=entity:getComponent("EnemyComponent")
	    local playercutiex, playercutiey = playercutie:getComponent("Position").x, playercutie:getComponent("Position").y
    	local xpos, ypos = entity:getComponent("Position").x, entity:getComponent("Position").y
    	local speed = main.worldspeed
		-- Ki
		if ypos <= 579 then
		    height = 500
		    if ypos <= 495 then
		        height = 400
		        if ypos <= 395 then
		            height = 300
		            if ypos <= 295 then
		                height = 200
		                if ypos <= 195 then
		                    height = 100
		                    if ypos <= 95 then
		                        height = 0
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

	        if  xpos <= (200 + (5-height/100)*50) or xpos >= (800 - (5-height/100)*50) then
	            enemy.check = 0
	            entity:getComponent("Physics").body:applyLinearImpulse(0, -6)
	            if ypos > 300 then
	                if xpos < playercutiex and (playercutiex - xpos) < 500 then
	                    entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	                elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
	                    entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	                elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
	                    entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	                elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
	                    entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	                end
	            else
	                if playercutiex > xpos then
	                    entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	                elseif playercutiex < xpos then
	                    entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	                end
	            end  
	        else
	            if enemy.direction == 1 then
	                entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	            elseif enemy.direction == 0 then
	                entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
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
	                    entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	                elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
	                    entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	                elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
	                    entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	                elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
	                    entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	                end
	            else
	                if playercutiex > xpos then
	                    entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	                elseif playercutiex < xpos then
	                    entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	                end
	            end
	        else
	            if enemy.direction == 1 then
	                entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	            elseif enemy.direction == 0 then
	                entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	            end
	        end
	    else
	        enemy.check = 0
	        if ypos > 300 then
	            if xpos < playercutiex and (playercutiex - xpos) < 500 then
	                entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	            elseif xpos < playercutiex and (playercutiex - xpos) > 500 then
	                entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	            elseif playercutiex < xpos and (xpos - playercutiex) < 500 then
	                entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	            elseif playercutiex < xpos and (xpos - playercutiex) > 500 then
	                entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	            end
	        else
	            if playercutiex > xpos then
	                entity:getComponent("Physics").body:applyLinearImpulse( 0.5*speed, 0)
	            elseif playercutiex < xpos then
	                entity:getComponent("Physics").body:applyLinearImpulse( -0.5*speed, 0)
	            end
	        end  
	     end
	end
end

function EnemyTrackingSystem:getRequiredComponents()
	return{"IsEnemy", "EnemyComponent"}
end