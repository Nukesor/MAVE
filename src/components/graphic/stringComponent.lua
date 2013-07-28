StringComponent = class("StringComponent")

function StringComponent:__init(string, font) 
	self.string = string
	self.font = font or resources.fonts.twenty
end