extends Area2D
class_name Bullet

@export var speed = 2000

func _process(delta):
	position += -transform.y * speed * delta
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

func _on_timer_timeout():
	queue_free()
