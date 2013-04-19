CollisionBounceSystem = class("CollisionBounceSystem", System)

function CollisionBounceSystem:__init()
    engine:addListener("BeginContact", self)
end

function CollisionBounceSystem:fireEvent(event)
print(contact)
end

