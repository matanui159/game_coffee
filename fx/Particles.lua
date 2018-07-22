local Particles = Object:extend()

function Particles:new()
	self.list = {}
end

function Particles:addParticle(x, y, r, g, b, life)
	table.insert(self.list, {
		x = x,
		y = y,
		red = r,
		green = g,
		blue = b,
		life = life
	})
end

function Particles:update()
	local i = 1
	while i <= #self.list do
		local part = self.list[i]
		part.y = part.y + 1
		part.life = part.life - 1
		if part.life == 0 then
			table.remove(self.list, i)
		else
			i = i + 1
		end
	end
end

function Particles:draw()
	for i, part in ipairs(self.list) do
		love.graphics.setColor(part.red, part.green, part.blue)
		love.graphics.rectangle("fill", part.x, part.y, 1, 1)
		love.graphics.setColor(1, 1, 1)
	end
end

return Particles