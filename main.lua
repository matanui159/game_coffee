require("conf")
Object = require("classic")

local GameScene = require("scenes.GameScene")
local timer = 0
local canvas

function love.load()
	math.randomseed(love.timer.getTime())
	love.graphics.setDefaultFilter("nearest")
	canvas = love.graphics.newCanvas(WIDTH, HEIGHT, {msaa = 4})
	scene = GameScene(true)
end

function love.update(dt)
	timer = timer + dt
	while timer > 0.1 do
		scene:update()
		timer = timer - 0.1
	end
end

function love.draw()
	love.graphics.setCanvas(canvas)
	scene:draw()
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, SCALE)
end