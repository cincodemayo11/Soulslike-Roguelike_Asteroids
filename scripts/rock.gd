extends Area2D
class_name Asteroid

signal rock_destroyed

var velocity = Vector2.ZERO

func _ready():
	randomize()
	var x = randf_range(-100, 100)
	randomize()
	var y = randf_range(-100, 100)
	velocity = Vector2(x, y)

func _process(delta):
	position += velocity * delta
	screenwrap()
	
func screenwrap():
	if position.x < 0:
		position.x = DisplayServer.window_get_size().x
	if position.x > DisplayServer.window_get_size().x:
		position.x = 0
	if position.y < 0:
		position.y = DisplayServer.window_get_size().y
	if position.y > DisplayServer.window_get_size().y:
		position.y = 0
		
func _on_area_entered(area):
	if area is Bullet:
		emit_signal("rock_destroyed")
		area.queue_free()
		queue_free()
		
