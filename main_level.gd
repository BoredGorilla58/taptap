extends Node2D

const SCENE_PIPE = preload("res://obj_obstacle.tscn")
var score = 0


func start_game():
	pass

func end_game():
	$CanvasLayer/scr_gameover.show()
	$pipes.process_mode = Node.PROCESS_MODE_DISABLED


func spawn_obstacles():
	var pipe = SCENE_PIPE.instantiate()
	$pipes.add_child(pipe)
	var ratio = score/5
	var gap = max( 256 - (score/3) , 96)
	var spd = ratio
	pipe.set_gap(gap)
	pipe.set_speed( 3 + spd )
	pipe.global_position.x = get_viewport_rect().size.x + 32
	pipe.global_position.y = 100 + (randf() * 500)

func _on_obj_bird_area_entered(area: Area2D) -> void:
	if area.name == "mid":
		score += 1
		$CanvasLayer/scr_game/score_label.text = str(score)
	else:
		$obj_bird.isDead = true
		end_game()


func _on_timer_timeout() -> void:
	spawn_obstacles()


func _on_retry_button_up() -> void:
	get_tree().reload_current_scene()
