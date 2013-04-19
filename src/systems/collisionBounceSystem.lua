CollisionBounceSystem = class("CollisionBounceSystem", System)

function CollisionBounceSystem:__init()
    engine:addListener("BeginContact", self)
end

function CollisionBounceSystem:fireEvent(event)
    if (( object1.__name == "DrawablePolygon" or object1.__name == "Cutie") and (object2.__name == "Cutie" or object2.__name == "DrawablePolygon")) then
        cutie2.jumpcount = 4
        if object1.__name == "Cutie" then
            local cutiexv, cutieyv = object1.body:getLinearVelocity()
            object1.body:setLinearVelocity(cutiexv, -200)
        elseif object2.__name == "Cutie" then
            local cutiexv, cutieyv = object2.body:getLinearVelocity()
            object2.body:setLinearVelocity(cutiexv, -200)
        end
    end"AWESOME CONTACT")
end

