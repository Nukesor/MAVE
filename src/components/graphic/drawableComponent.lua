local DrawableComponent = Component.create("DrawableComponent")

function DrawableComponent:initialize(image, r, sx, sy, ox, oy)
    self.image = image
    self.r = r
    if sx then self.sx = sx * relation() end
    if sy then self.sy = sy * relation() end
    if ox then self.ox = ox * relation() end
    if oy then self.oy = oy * relation() end
end

return DrawableComponent
