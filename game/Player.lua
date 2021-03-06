local TransitionScene = require("scenes.TransitionScene")

local Player = Object:extend()

function Player:new(gamescene, key, coffee, y)
	if not Player.load then
		Player.walk = {
			love.graphics.newImage("assets/player/walk1.png"),
			love.graphics.newImage("assets/player/walk2.png")
		}
		Player.win = {
			love.graphics.newImage("assets/player/win1.png"),
			love.graphics.newImage("assets/player/win2.png")
		}
		Player.lose = love.graphics.newImage("assets/player/lose.png")
		Player.egg = love.graphics.newImage("assets/player/egg.png")
		Player.load = true
	end

	self.gamescene = gamescene
	self.key = key
	self.coffee = coffee
	self.x = 2
	self.y = y
	self.win = false
	self.lose = false
	self.cry = 0
	self.wintime = 0
end

function Player:update(other)
	if self.lose then
		self.cry = self.cry + 1
		local y = self.y + 6
		local r = 0.0
		local g = 0.4
		local b = 0.8
		local life = 5
		if self.cry % 4 == 0 then
			scene:addParticle(self.x + 7, y, r, g, b, life)
		elseif self.cry % 4 == 2 then
			scene:addParticle(self.x + 9, y, r, g, b, life)
		end
	else

		if self.win then
			scene:addParticle(
				self.x + math.random(4, 20),
				self.y,
				math.random(),
				math.random(),
				math.random(),
				14
			)

			self.wintime = self.wintime + 1
			if self.wintime > 10 and not scene:is(TransitionScene) then
				scene = TransitionScene(self.gamescene())
			end
		end

		if self.win or love.keyboard.isDown(self.key) or self.x % 2 ~= 0 then
			if not self.win then
				self.coffee:force(self.x)
			end
			self.x = self.x + 1
			if self.x > 55 then
				self.win = true
				other.lose = true
			end
		end
	end

	if self.coffee:update() and not self.win then
		self.lose = true
		other.win = true
		scene:addParticle(self.x + 13, self.y + 6, 0.45, 0.15, 0.05, 3)
	end
end

function Player:draw()
	if self.win then
		love.graphics.draw(Player.win[self.x % 2 + 1], self.x, self.y)
	elseif self.lose then
		love.graphics.draw(Player.lose, self.x, self.y)
	else
		love.graphics.draw(Player.walk[self.x % 2 + 1], self.x, self.y)
	end

	if scene.egg then
		love.graphics.push()
		if self.lose then
			love.graphics.translate(1, 1)
		elseif self.x % 2 ~= 0 then
			love.graphics.translate(0, -1)
		end
		love.graphics.draw(Player.egg, self.x, self.y)
		love.graphics.pop()
	end
end

return Player