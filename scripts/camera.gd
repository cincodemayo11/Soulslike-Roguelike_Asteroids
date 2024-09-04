extends Camera2D

var magnitude : float = 0.0
var time = 0
var frequency = 50
var x_shake_start = 0
var y_shake_start = 0

func _process(delta):
	time += delta
	magnitude = lerp(magnitude, 0.0, delta * 0.5)
	offset.x = sin(time * frequency + x_shake_start) * magnitude
	offset.y = sin(time * frequency + y_shake_start) * magnitude
	#offset.y = sin(time) * 100
	
func shake():
	randomize()
	magnitude = 1
	x_shake_start = randf_range(0, 2 * PI)
	y_shake_start = randf_range(0, 2 * PI)
