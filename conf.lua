WIDTH  = 96
HEIGHT = 48
SCALE  = 12

function love.conf(config)
	config.window.title = "Coffee Run"
	config.window.width = WIDTH * SCALE
	config.window.height = HEIGHT * SCALE
end