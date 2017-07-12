local StringComponent = Component.create("StringComponent")

function StringComponent:initialize(font, color,string, values)
    self.font = font
    self.string = string
    self.color = color
    self.values = values
end

return StringComponent
