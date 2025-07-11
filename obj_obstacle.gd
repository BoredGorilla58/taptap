extends Node2D

var speed : int = 3

func _physics_process(delta: float) -> void:
	global_position.x -= speed
	
	if global_position.x < -64:
		queue_free()

func set_speed(spd : int = 3):
	speed = spd

func set_gap(size : int = 10):
	$upper.position.y = -size
