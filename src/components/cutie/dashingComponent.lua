DashingComponent = class("DashingComponent")

function DashingComponent:__init(startPosition, targetPosition) 
    self.time = 0
    self.targetPosition = {x= targetPosition["x"] * relation(), y=targetPosition["y"] * relation()}
    self.startPosition = {x=startPosition["x"] * relation(), y=startPosition["y"] * relation()}
end