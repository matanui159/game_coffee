local Coffee = Object:extend()

function Coffee:new(y)
	self.vel = 0
	self.offset = 0

	self.width = 12
	self.height = 7
	self.x = 80
	self.y = y + self.height

	self.mesh = love.graphics.newMesh({
		{self.x, self.y},
		{self.x + self.width, self.y},
		{self.x + self.width, self.y + self.height},
		{self.x, self.y + self.height}
	})
end

function Coffee:force(x)
	self.vel = self.vel - (1 + x / 20) / 20
end

function Coffee:update()
	self.vel = self.vel - self.offset / 10
	self.vel = self.vel * 0.9
	self.offset = self.offset + self.vel
	if self.offset < -1 then
		self.offset = -1
	end

	self.mesh:setVertices({
		{self.x, self.y + self.offset * self.height},
		{self.x + self.width, self.y - self.offset * self.height}
	})

	return self.offset < -0.9
end

function Coffee:draw()
	love.graphics.setColor(0.45, 0.15, 0.05)
	love.graphics.draw(self.mesh)
	love.graphics.setColor(1, 1, 1)
end

return Coffee