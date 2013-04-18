Dashing = class("Dashing")

function Dashing:__init(startVelocity, startPosition, targetPosition) 
    self.time = 0
    self.startVelocity = startVelocity
    self.targetPosition = targetPosition
    self.startPosition = startPosition
end