CollisionDamageSystem = class("CollisionDamageSystem", System)

function CollisionDamageSystem:update(dt) end

function CollisionDamageSystem:beginContact(a, b, coll)
    local object1 = a:getUserData()[1]
    local object1Entity = a:getUserData()[2]
    local object2 = b:getUserData()[1]
    local object2Entity = b:getUserData()[2]

    if object1 and object2 then
        print("object 1 and object 2 are not nil")
        if (object1.__name == "Playercutie" or object1.__name == "Cutie") and (object2.__name == "Playercutie" or object2.__name == "Cutie") then
            print("playing audio")
            love.audio.play(resources.sounds.bounce1)

            print("audio played")

            local object1Cuteness, object2Cuteness

            if object1.cuteness then object1Cuteness = object1.cuteness else object1Cuteness = object1.entity:getComponent("Cuteness").cuteness end
            if object2.cuteness then object2Cuteness = object2.cuteness else object2Cuteness = object2.entity:getComponent("Cuteness").cuteness end

            -- Schadensmodell
            if math.random(0, 100 + 2*object2Cuteness) > 100 then
                object1:loseLife(3*math.random(0, 5 + object2Cuteness))
                main.shaketimer = 0.25
            else
                print("calling object 1 loseLife")
                object1:loseLife(math.random(0, 5 + object2Cuteness))
            end
            if math.random(0, 100 + 2*object1Cuteness) > 100 then
                object2:loseLife(3*math.random(0, 5 + object1Cuteness))
                main.shaketimer = 0.25
            else
                print("calling object 2 loseLife")
                object2:loseLife(math.random(0, 5 + object1Cuteness))
            end
            print("collision function ended")
        end
    end
end

function CollisionDamageSystem:getRequiredComponents()
    return {}
end