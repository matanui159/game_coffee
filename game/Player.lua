local Player = Object:extend()

function Player:new(key, coffee, y)
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
		Player.load = true
	end

	self.key = key
	self.coffee = coffee
	self.x = 2
	self.y = y
	self.win = false
	self.lose = false
	self.cry = 0
end

function Player:update(other)
	if self.lose then
		self.cry = self.cry + 1
		local y = self.y + 6
		local r = 0.0
		local g = 0.4
		local b = 0.8
		local life = 8
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
end

function Player:drawCoffee()
	local height = 7 + 7 * self.coffee.level
	love.graphics.setColor(0.45, 0.15, 0.05)
	love.graphics.rectangle("fill", self.coffee.x, self.coffee.y - height, 12, height)
	love.graphics.setColor(1, 1, 1)
end

return Player