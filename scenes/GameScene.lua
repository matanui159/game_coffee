local Particles = require("fx.Particles")

local Player = require("game.Player")
local Coffee = require("game.Coffee")

local GameScene = Object:extend()

function GameScene:new()
	if not GameScene.load then
		GameScene.bg = love.graphics.newImage("assets/bg.png")
		GameScene.fg = love.graphics.newImage("assets/fg.png")
		GameScene.logo = love.graphics.newImage("assets/logo.png")
		GameScene.tut = love.graphics.newImage("assets/tut.png")

		GameScene.music = {}
		GameScene.music.start = love.audio.newSource("assets/music/start.mp3", "stream")
		GameScene.music.play = love.audio.newSource("assets/music/play.mp3", "stream")

		GameScene.load = true
	end

	self.particles = Particles()
	self.players = {
		Player(GameScene, "lctrl", Coffee(12), 16),
		Player(GameScene, "rctrl", Coffee(30), 32)
	}
end

function GameScene:addParticle(x, y, r, g, b, life)
	self.particles:addParticle(x, y, r, g, b, life)
end

function GameScene:update()
	self.particles:update()
	self.players[1]:update(self.players[2])
	self.players[2]:update(self.players[1])

	if self.players[1].x == 2 and self.players[2].x == 2 then
		GameScene.music.play:stop()
		GameScene.music.start:play()
	else
		GameScene.music.start:stop()
		GameScene.music.play:play()
	end
end

function GameScene:draw()
	love.graphics.draw(GameScene.bg)
	love.graphics.draw(GameScene.logo)
	self.players[1]:draw()
	self.players[2]:draw()
	self.particles:draw()
	love.graphics.draw(GameScene.fg)
	self.players[1].coffee:draw()
	self.players[2].coffee:draw()

	if self.players[1].x == 2 and self.players[2].x == 2 then
		love.graphics.draw(GameScene.tut)
	end
end

return GameScene