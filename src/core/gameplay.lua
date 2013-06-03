Gameplay = class("Gameplay")

function Gameplay:__init()
	self.time = 0
	self.Highscore = 0
	self.level = 1
	self.kills = 0

	self.gold = 0
	self.items = {
		{"Gewehr", false, false, 100}
		{"Granatwerfer", false, false, 300}
		{"Granate", false, false, 100}
		{"Mine", false, false, 200}
		{"Hammer", false, false, 50}
	}
end