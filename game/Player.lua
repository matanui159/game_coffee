local Player = Object:extend()

function Player:new(key, coffee, y)
	if not Player.load then
		Player.walk = {
			love.graphics.newImage("assets/walk/1.png"),
			love.graphics.newImage("assets/walk/2.png")
		}
		Player.load = true
	end

	self.key = key
	self.coffee = coffee
	self.x = 2
	self.y = y
end

function Player:update()
	if love.keyboard.isDown(self.key) or self.x % 2 ~= 0 then
		self.coffee:force(self.x)
		self.x = self.x + 1
		if self.x > 55 then
			print(self.key .. " win")
		end
	end
	if self.coffee:update() then
		print(self.key .. " lose")
	end
end

function Player:draw()
	love.graphics.draw(Player.walk[self.x % 2 + 1], self.x, self.y)
end

function Player:drawCoffee()
	local height = 7 + 7 * self.coffee.level
	love.graphics.setColor(0.45, 0.15, 0.05)
	love.graphics.rectangle("fill", self.coffee.x, self.coffee.y - height, 12, height)
	love.graphics.setColor(1, 1, 1)
end

return Player