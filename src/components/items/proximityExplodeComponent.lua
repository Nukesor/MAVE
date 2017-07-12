local ProximityExplodeComponent = Component.create("ProximityExplodeComponent")

function ProximityExplodeComponent:initialize(radius)
    self.radius = radius * relation()
end

return ProximityExplodeComponent
