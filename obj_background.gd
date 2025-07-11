extends TextureRect

var scroll_speed = Vector2(0.1, 0)  # pixels per second (X, Y)
var uv_offset := Vector2.ZERO

func _process(delta):
	uv_offset += scroll_speed * delta
	material.set_shader_parameter("uv_offset", uv_offset)
