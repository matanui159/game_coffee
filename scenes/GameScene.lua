local Player = require("game.Player")
local Coffee = require("game.Coffee")

local GameScene = Object:extend()

function GameScene:new()
	if not GameScene.load then
		GameScene.bg = love.graphics.newImage("assets/bg.png")
		GameScene.fg = love.graphics.newImage("assets/fg.png")
		GameScene.load = true
	end

	self.players = {
		Player("lctrl", Coffee(12), 16),
		Player("rctrl", Coffee(30), 32)
	}
end

function GameScene:update()
	self.players[1]:update()
	self.players[2]:update()
end

function GameScene:draw()
	love.graphics.draw(GameScene.bg)
	self.players[1]:draw()
	self.players[2]:draw()
	love.graphics.draw(GameScene.fg)
	self.players[1].coffee:draw()
	self.players[2].coffee:draw()
end

return GameScene