StringComponent = class("StringComponent")

function StringComponent:__init(font, string, values) 
	self.font = font or resources.fonts.twenty
	self.string = string
	self.values = values
end