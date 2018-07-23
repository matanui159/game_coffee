local TransitionScene = Object:extend()

function TransitionScene:__index(key)
	if TransitionScene[key] then
		return TransitionScene[key]
	elseif self.y > 0 then
		return self.prev[key]
	else
		return self.next[key]
	end
end

function TransitionScene:new(next)
	self.prev = scene
	self.next = next
	self.y = HEIGHT
end

function TransitionScene:update()
	if self.y > 0 then
		self.prev:update()
	else
		self.next:update()
	end

	self.y = self.y - 8
	if self.y < -HEIGHT then
		scene = self.next
		self.prev = nil
		collectgarbage()
	end
end

function TransitionScene:draw()
	if self.y > 0 then
		self.prev:draw()
	else
		self.next:draw()
	end

	love.graphics.setColor(0.45, 0.15, 0.05)
	love.graphics.rectangle("fill", 0, self.y, WIDTH, HEIGHT)
	love.graphics.setColor(1, 1, 1)
end

return TransitionScene