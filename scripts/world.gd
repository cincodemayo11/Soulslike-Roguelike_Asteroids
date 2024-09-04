extends Node2D

var num_asteroids = 1
@onready var big_asteroid = preload("res://scenes/big_asteroid.tscn")
@onready var bullet = preload("res://scenes/bullet.tscn")
@onready var small_asteroid = preload("res://scenes/rock.tscn")

var num_rocks_left = 0
var num_asteroids_left = 0
var score = 0

func _ready():
	spawn_wave()
	
func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		if $player != null:
			var new_bullet = bullet.instantiate()
			new_bullet.position = $player.position
			new_bullet.rotation = $player.rotation
			add_child(new_bullet)
			$laser_sound.play()
	if num_asteroids_left <= 0 and num_rocks_left <= 0:
		num_asteroids += 2
		spawn_wave()

func get_random_position() -> Vector2:
	randomize()
	var x = randf_range(0, DisplayServer.window_get_size().x)
	var y = randf_range(0, DisplayServer.window_get_size().y)
	return Vector2(x, y)

func on_asteroid_destroyed(pos):
	$explosion.play()
	$camera.shake()
	make_rock(pos)
	score += 2
	$canvaslayer/score_label.text = "Score: " + str(score).pad_zeros(4)
	num_asteroids_left -= 1

func on_rock_destroyed():
	$explosion.play()
	$camera.shake()
	score += 1
	$canvaslayer/score_label.text = "Score: " + str(score).pad_zeros(4)
	num_rocks_left -= 1

func spawn_wave():
	for n in num_asteroids:
		var new_asteroid = big_asteroid.instantiate()
		new_asteroid.position = get_random_position()
		new_asteroid.connect("asteroid_destroyed", on_asteroid_destroyed)
		add_child(new_asteroid)
		num_asteroids_left += 1
		
func make_rock(asteroid_pos):
	for i in range (0,2):
		var new_rock = small_asteroid.instantiate()
		new_rock.position = asteroid_pos
		new_rock.connect("rock_destroyed", on_rock_destroyed)
		add_child(new_rock)
		num_rocks_left += 1

func _on_player_player_dead():
	$player.queue_free()
	$Timer.start()
	$canvaslayer/score_label.position = Vector2(DisplayServer.window_get_size().x / 2 - 150, DisplayServer.window_get_size().y / 2)


func _on_timer_timeout():
	get_tree().reload_current_scene()
