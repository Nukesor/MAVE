Dashing = class("Dashing")

function Dashing:__init(xBefore, yBefore, targetPosition) 
    self.time = 0
    self.xVelocityBefore = xBefore
    self.yVelocityBefore = yBefore
    self.targetPosition = targetPosition
end