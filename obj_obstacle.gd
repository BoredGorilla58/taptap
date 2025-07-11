extends Node2D

var speed : int = 3
var origin_pos : Vector2


func reset():
	global_position.x = get_viewport_rect().size.x
	global_position.y = 200 + (randf() * 500)
	set_gap()

func _physics_process(delta: float) -> void:
	global_position.x -= speed
	
	if global_position.x < -64:
		reset()

func set_speed(spd : int = 3):
	speed = spd

func set_gap():
	var score = $"../..".score
	var add = max(256 -(32 * (score/5)),0)
	var gap = 64 + add
	$upper.position.y = -gap
