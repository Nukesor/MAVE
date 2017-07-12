local DashingComponent = Component.create("DashingComponent")

function DashingComponent:initialize(startPosition, targetPosition)
    self.time = 0
    self.targetPosition = {x= targetPosition["x"] * relation(), y=targetPosition["y"] * relation()}
    self.startPosition = {x=startPosition["x"] * relation(), y=startPosition["y"] * relation()}
end

return DashingComponent
