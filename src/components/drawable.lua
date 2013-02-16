Drawable = class("Drawable")

function Drawable:__init(image, x, y, sx, sy, ox, oy)
    self.image = image
    self.x = x
    self.y = y
    self.sx = sx
    self.sy = sy
    self.ox = ox
    self.oy = oy
end