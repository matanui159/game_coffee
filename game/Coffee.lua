local Coffee = Object:extend()

function Coffee:new(y)
	self.level = 0
	self.x = 80
	self.y = y + 7

	self.mesh = love.graphics.newMesh({
		{self.x, self.y},
		{self.x + 12, self.y},
		{self.x + 12, self.y + 7},
		{self.x, self.y + 7}
	})
end

function Coffee:force(x)
	local force = x / 300 * (self.level + 1)
	self.level = self.level + force
	if self.level > 1 then
		self.level = 1
	end
end

function Coffee:update()
	self.level = self.level * 0.9
	local offset = math.sin(love.timer.getTime() * 3) * self.level * 7
	self.mesh:setVertices({
		{self.x, self.y + offset},
		{self.x + 12, self.y - offset}
	})

	return math.abs(offset) > 6
end

function Coffee:draw()
	love.graphics.setColor(0.45, 0.15, 0.05)
	love.graphics.draw(self.mesh)
	love.graphics.setColor(1, 1, 1)
end

return Coffee