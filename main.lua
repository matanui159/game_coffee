Object = require("classic")

WIDTH  = 96
HEIGHT = 48
SCALE  = 8

local GameScene = require("scenes.GameScene")
local canvas

function love.load()
	love.graphics.setDefaultFilter("nearest")
	canvas = love.graphics.newCanvas(WIDTH, HEIGHT, {msaa = 4})
	scene = GameScene()
end

function love.update(dt)
	scene:update(dt)
end

function love.draw()
	love.graphics.setCanvas(canvas)
	scene:draw()
	love.graphics.setCanvas()
	love.graphics.draw(canvas, 0, 0, 0, SCALE)
end