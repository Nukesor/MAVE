DrawableComponent = class("DrawableComponent")

function DrawableComponent:__init(image, r, sx, sy, ox, oy)
    self.image = image
    self.r = r
    if sx then self.sx = sx * relation() end
    if sy then self.sy = sy * relation() end
    self.ox = ox * relation()
    self.oy = oy * relation()
end