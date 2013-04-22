require("core/helper")

DrawableComponent = class("DrawableComponent")

function DrawableComponent:__init(image, r, sx, sy, ox, oy)
    self.image = image
    self.r = r
    self.sx = sx
    self.sy = sy
    self.ox = ox
    self.oy = oy
end