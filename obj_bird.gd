extends Area2D

const TEXTURE_OPEN = preload("res://textures/bird_1.png")
const TEXTURE_CLOSE = preload("res://textures/bird_2.png")

@export var fly_force = 10.0
@export var gravity_force = 3.0

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_SPACE:
			if event.pressed and velocity < 2:
				fly()

var velocity = 0

func _physics_process(delta: float) -> void:
	if velocity < 1:
		global_position.y += gravity_force
		$sprite.texture = TEXTURE_OPEN
	else:
		global_position.y -= velocity
		velocity -= 1



func fly():
	velocity = fly_force
	$sprite.texture = TEXTURE_CLOSE
