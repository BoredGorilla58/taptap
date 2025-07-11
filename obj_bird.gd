extends Area2D

const TEXTURE_OPEN = preload("res://textures/bird_1.png")
const TEXTURE_CLOSE = preload("res://textures/bird_2.png")

@export var fly_force = 15.0
@export var gravity_force = 9.8

var isDead = false



var velocity = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("tap"):
		if velocity < 5:
			fly()

func _physics_process(delta: float) -> void:
	if velocity < 1:
		global_position.y += gravity_force
		$sprite.texture = TEXTURE_OPEN
		
	else:
		global_position.y -= velocity
		velocity -= 1
	
	global_rotation = lerp_angle(global_rotation,45,0.1)



func fly():
	if not isDead:
		velocity = fly_force
		$sprite.texture = TEXTURE_CLOSE
		global_rotation = -45
