DashingComponent = class("DashingComponent")

function DashingComponent:__init(startPosition, targetPosition) 
    self.time = 0
    self.targetPosition = targetPosition
    self.startPosition = startPosition
end