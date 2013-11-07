BoxComponent = class("BoxComponent")

function BoxComponent:__init(width, height, linked, image, xscale)
    self.width = width * relation()
    self.height = height * relation()
    self.selected = false
    self.linked = linked
    if image then
        self.image = image
        self.scale = xscale
    end
end