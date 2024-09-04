extends Area2D

@export var move_speed = 20
@export var rotation_speed = 7
var velocity = Vector2.ZERO
var thrust = 0
signal player_dead

func _ready():
	position = Vector2((DisplayServer.window_get_size().x / 2), (DisplayServer.window_get_size().y / 2))
		
func _process(delta):
	#position += transform.y * Input.get_axis("ui_up","ui_down") * move_speed * delta
	rotation += Input.get_axis("ui_left", "ui_right") * rotation_speed * delta
	thrust = Input.get_action_strength("ui_up")
	velocity += -transform.y * thrust * move_speed
	velocity = lerp(velocity, Vector2.ZERO, 1 * delta)
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
	if not area is Bullet:
		emit_signal("player_dead")
		
