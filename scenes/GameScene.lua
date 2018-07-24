local Particles = require("fx.Particles")

local Player = require("game.Player")
local Coffee = require("game.Coffee")

local GameScene = Object:extend()

function GameScene:new(first)
	if not GameScene.load then
		GameScene.bg = love.graphics.newImage("assets/bg.png")
		GameScene.fg = love.graphics.newImage("assets/fg.png")
		GameScene.logo = love.graphics.newImage("assets/logo.png")
		GameScene.egg = love.graphics.newImage("assets/egg.png")
		GameScene.tut = love.graphics.newImage("assets/tut.png")

		GameScene.music = {}
		GameScene.music.start = love.audio.newSource("assets/music/start.mp3", "stream")
		GameScene.music.play = love.audio.newSource("assets/music/play.mp3", "stream")

		GameScene.load = true
	end

	self.particles = Particles()
	self.players = {
		Player(GameScene, "space", Coffee(12), 16),
		Player(GameScene, "return", Coffee(30), 32)
	}

	if not first and math.random(1, 4) == 1 then
		self.egg = true
	else
		self.egg = false
	end
end

function GameScene:addParticle(x, y, r, g, b, life)
	self.particles:addParticle(x, y, r, g, b, life)
end

function GameScene:update()
	self.particles:update()
	self.players[1]:update(self.players[2])
	self.players[2]:update(self.players[1])

	local music = GameScene.music
	if self.players[1].x == 2 and self.players[2].x == 2 then
		music.play:stop()
		if not music.start:isPlaying() then
			music.start:seek(math.random(1, 120))
			music.start:play()
		end
	else
		music.start:stop()
		if not music.play:isPlaying() then
			music.play:seek(math.random(1, 240))
			music.play:play()
		end
	end
end

function GameScene:draw()
	love.graphics.draw(GameScene.bg)
	if self.egg then
		love.graphics.draw(GameScene.egg)
	else
		love.graphics.draw(GameScene.logo)
	end

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