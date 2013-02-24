require("core/helper")

Drawable = class("Drawable")

function Drawable:__init(image, r, sx, sy, ox, oy)
    self.image = image
    self.r = r
    self.sx = sx
    self.sy = sy
    self.ox = ox
    self.oy = oy
end