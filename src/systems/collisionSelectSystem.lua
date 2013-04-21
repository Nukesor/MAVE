require("collisions/bounceCollision")
require("collisions/collisionDamageSystem")

CollisionSelectSystem = class("CollisionDetectSystem", System)

function CollisionSelectSystem:__init()
    self.conditions = {}

    local bounce = BounceCollision()
    self:addCollisionAction(bounce.component1, bounce.component2, bounce.action)
    local damage = CollisionDamageSystem()
    self:addCollisionAction(damage.component1, damage.component2, damage.action)
end

function CollisionSelectSystem:addCollisionAction(component1, component2, action)
    self.conditions[component1] = {}
    self.conditions[component1][component2] = action
    self.conditions[component2] = {}
    self.conditions[component2][component1] = action
end

function CollisionSelectSystem:fireEvent(event)
    local e1 = event.a:getUserData()
    local e2 = event.b:getUserData()

    for k,v in pairs(e1:getComponents()) do
        for key,val in pairs(e2:getComponents()) do
            if self.conditions[k] then
                if self.conditions[k][key] then self.conditions[k][key]({entity1=e1, entity2=e2}) break end
            elseif self.conditions[key] then
                if self.conditions[key][k] then self.conditions[key][k]({entity1=e2, entity2=e1}) break end
            end
        end
    end
end