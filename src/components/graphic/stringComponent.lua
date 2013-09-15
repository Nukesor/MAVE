StringComponent = class("StringComponent")

function StringComponent:__init(font, string, values) 
    self.font = font
    self.string = string
    self.values = values
end